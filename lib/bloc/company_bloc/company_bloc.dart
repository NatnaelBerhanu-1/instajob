import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/company_repo.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository companyRepository;
  CompanyModel companyModel = CompanyModel();
  _getList(Emitter emit) async {
    ApiResponse response = await companyRepository.getCompanies();
    if (response.response.statusCode == 500) {
      emit(const ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      List<CompanyModel> list = (response.response.data['data'] as List)
          .map((e) => CompanyModel.fromJson(e))
          .toList();
      emit(CompanyLoaded(list));

      return list;
    } else if (response.response.statusCode == 400) {
      print("1111111111111111111111");
      emit(const ErrorState("Data not found"));
    }
  }

  CompanyBloc(this.companyRepository) : super(Initial()) {
    on<LoadCompanyListEvent>((event, emit) async {
      emit(CompanyLoading());
      List<CompanyModel> companyList = await _getList(emit);
      emit(CompanyLoaded(companyList));
      if (companyList.isEmpty) {
        emit(const ErrorState("Data not found"));
      }
    });

    on<AddCompanyEvent>((event, emit) async {
      await companyRepository.addCompany(
          name: event.companyName, photo: event.photo);
      await _getList(emit);
    });

    on<CompanySearchEvent>((event, emit) async {
      emit(CompanyLoading());
      var list = await _getSearchCompany(emit, search: event.search);
      emit(SearchCompanyLoaded(list));
      if (list.isEmpty) {
        emit(const ErrorState("Data not found"));
      }
    });
    on<JobSearchEvent>((event, emit) async {
      emit(CompanyLoading());
      var jobList = await _getSearchJobs(emit, search: event.search);
      emit(SearchJobLoaded(jobList));
      if (jobList.isEmpty) {
        emit(const ErrorState("Data not found"));
      }
    });
  }

  _getSearchCompany(Emitter emit, {String? search}) async {
    ApiResponse response = await companyRepository.searchCompany(
      search: search,
    );
    if (response.response.statusCode == 500) {
      emit(const ErrorState('Something went wrong'));
    }
    if (response.response.statusCode == 200) {
      List<CompanyModel> list = (response.response.data['data'] as List)
          .map((e) => CompanyModel.fromJson(e))
          .toList();
      emit(SearchCompanyLoaded(list));
      print('LISTTT ------------            $list');
      return list;
    } else if (response.response.statusCode == 400) {
      emit(ErrorState(response.response.data['message']));
    }
  }

  _getSearchJobs(Emitter emit, {String? search}) async {
    ApiResponse response = await companyRepository.searchJobs(search: search);
    if (response.response.statusCode == 500) {
      emit(const ErrorState('Something went wrong'));
    }
    if (response.response.statusCode == 200) {
      List<JobPosModel> list = (response.response.data['data'] as List)
          .map((e) => JobPosModel.fromJson(e))
          .toList();
      emit(SearchJobLoaded(list));
      print('LISTTT ------------            $list');
      return list;
    } else if (response.response.statusCode == 400) {
      emit(ErrorState(response.response.data['message']));
    }
  }
}

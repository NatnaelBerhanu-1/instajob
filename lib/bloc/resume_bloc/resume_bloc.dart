import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_event.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/model/resume_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/resume_repo.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  final ResumeRepository resumeRepository;
  getResumeData(String id, Emitter emit) async {
    ApiResponse response = await resumeRepository.getResume(id: id);
    if (response.response.statusCode == 500) {
      emit(const ErrorState("Something went wrong"));
    }
    if (response.response.success == 200) {
      ResumeModel resumeModel =
          ResumeModel.fromJson(response.response.data['data']);
      emit(ResumeLoaded(resumeModel: resumeModel));
    } else if (response.response.success == 400) {
      emit(const ErrorState("Data not found"));
    }
  }

  ResumeBloc(this.resumeRepository) : super(ResumeInitial()) {
    on<LoadResumeEvent>((event, emit) async {
      var resumeData = await getResumeData(event.id, emit);
      emit(ResumeLoaded(resumeModel: resumeData));
    });
    on<AddResumeEvent>((event, emit) async {
      ApiResponse response = await resumeRepository.addResume(
        name: event.resumeModel.yourName,
        passion: event.resumeModel.yourPassion,
        pWork: event.resumeModel.previousWork,
        skills: event.resumeModel.yourTop5Skills,
        phoneNumber: event.resumeModel.phoneNumber.toString(),
      );
      await getResumeData(response.response.data['data']['id'], emit);
      print(
          "QQQQQQQQQQQQQQ -------------  ${response.response.data['data']['id']}");
    });

    on<AddEducationEvent>((event, emit) async {
      ApiResponse response = await resumeRepository.addEducation(
          educationModel: event.educationModel);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        emit(ResumeInitial());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
    });

    on<TellMeAbtYourSelfEvent>((event, emit) async {
      ApiResponse response =
          await resumeRepository.addTellAbtSelf(tellUs: event.data);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        emit(ResumeInitial());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
    });

    on<AddWorkExpEvent>((event, emit) async {
      ApiResponse response = await resumeRepository.addWorkExperience(
          educationModel: event.educationModel);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        // showToast("Success");
        emit(ResumeInitial());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
    });

    on<AddSkillsEvent>((event, emit) async {
      ApiResponse response =
          await resumeRepository.addSkills(skills: event.skills);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        // showToast("Success");
        emit(ResumeInitial());
      }
      if (response.response.statusCode == 400) {
        emit(const ErrorState("Data Not Found"));
      }
    });
  }
/*
  String name = "";
  String phone = "";
  String passion = "";
  String pWork = "";
  changeName(val) {
    name = val;
    emit(NameState());
  }

  changePhone(val) {
    phone = val;

  }

  changePassion(val) {
    passion = val;
  }

  changePWork(val) {
    pWork = val;
  }*/
}
/*
  bool readOnly = true;
  bool isConfirm = false;
on<CheckReadOnlyEvent>((event, emit) {
      readOnly = event.readOnly;
      emit(CheckReadOnly(readOnly));
    });
    on<CheckIsConfirmEvent>((event, emit) {
      isConfirm = event.isConfirm;
      emit(CheckConfirm(isConfirm));
    });*/

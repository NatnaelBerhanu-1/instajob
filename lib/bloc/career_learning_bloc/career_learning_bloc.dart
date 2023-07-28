import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_state.dart';
import 'package:insta_job/model/career_learning_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/career_learning_repo.dart';

class CareerLearningBloc extends Cubit<InitialCareerLearning> {
  final CareerLearningRepo careerLearningRepo;
  CareerLearningBloc(this.careerLearningRepo) : super(InitialCareerLearning());
  List<CareerClusterModel> list = [];
  List<TaskModel> taskList = [];
  List<TechSkillModel> techSkillList = [];
  List<ClusterDetailsModel> careerDetailList = [];
  CareerClusterModel careerClusterModel = CareerClusterModel();

  getCareerClusterList() async {
    ApiResponse response = await careerLearningRepo.getCareerClusterList();
    if (response.response.statusCode == 500) {
      emit(CareerErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      list = (response.response.data['career_cluster'] as List)
          .map((e) => CareerClusterModel.fromJson(e))
          .toList();
      emit(CareerLoaded(list));

      // return list;
    } else if (response.response.statusCode == 400) {
      emit(CareerErrorState("Data not found"));
    }
  }

  getClusterDetailList({String? code}) async {
    emit(CareerLeaningLoading());
    ApiResponse response = await careerLearningRepo.getCareerClusterList(
        code: code, isDetail: true);
    if (response.response.statusCode == 500) {
      emit(CareerErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      careerDetailList = (response.response.data['occupation'] as List)
          .map((e) => ClusterDetailsModel.fromJson(e))
          .toList();
      emit(CareerDetailLoaded(careerDetailList));

      // return list;
    } else if (response.response.statusCode == 400) {
      emit(CareerErrorState("Data not found"));
    }
  }

  getDetailList({required String url}) async {
    emit(CareerLeaningLoading());
    ApiResponse response = await careerLearningRepo.getClusterDetailList(url);
    if (response.response.statusCode == 500) {
      emit(CareerErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      careerClusterModel = CareerClusterModel.fromJson(response.response.data);
      emit(DetailLoaded(careerClusterModel));

      return careerClusterModel;
    } else if (response.response.statusCode == 400) {
      emit(CareerErrorState("Data not found"));
    }
  }

  getTaskList({required String code}) async {
    emit(CareerLeaningLoading());
    ApiResponse response =
        await careerLearningRepo.taskDetailList(code, "tasks");
    if (response.response.statusCode == 500) {
      emit(CareerErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      taskList = (response.response.data['task'] as List)
          .map((e) => TaskModel.fromJson(e))
          .toList();
      emit(TaskLoaded(taskList));

      // return list;
    } else if (response.response.statusCode == 400) {
      emit(CareerErrorState("Data not found"));
    }
  }

  getTechList({required String code}) async {
    emit(CareerLeaningLoading());
    ApiResponse response =
        await careerLearningRepo.taskDetailList(code, "technology_skills");
    if (response.response.statusCode == 500) {
      emit(CareerErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      techSkillList = (response.response.data['category'] as List)
          .map((e) => TechSkillModel.fromJson(e))
          .toList();
      emit(TechSkillLoaded(techSkillList));
    } else if (response.response.statusCode == 400) {
      emit(CareerErrorState("Data not found"));
    }
  }

  /// DROPDOWN VALUE
  CareerClusterModel? dropDownValue;
  changeDropDownValue(val) {
    dropDownValue = val;
    emit(DropDownState(dropDownValue!));
  }

  clearValue() {
    dropDownValue = null;
    emit(InitialCareerLearning());
  }
}

import 'package:insta_job/model/career_learning_model.dart';

class InitialCareerLearning {}

class CareerLeaningLoading extends InitialCareerLearning {}

class CareerLoaded extends InitialCareerLearning {
  final List<CareerClusterModel> list;

  CareerLoaded(this.list);
}

class TaskLoaded extends InitialCareerLearning {
  final List<TaskModel> list;

  TaskLoaded(this.list);
}

class TechSkillLoaded extends InitialCareerLearning {
  final List<TechSkillModel> list;

  TechSkillLoaded(this.list);
}

class CareerDetailLoaded extends InitialCareerLearning {
  final List<ClusterDetailsModel> list;

  CareerDetailLoaded(this.list);
}

class DetailLoaded extends InitialCareerLearning {
  final CareerClusterModel data;

  DetailLoaded(this.data);
}

class CareerErrorState extends InitialCareerLearning {
  final String error;

  CareerErrorState(this.error);
}

class DropDownState extends InitialCareerLearning {
  final CareerClusterModel val;

  DropDownState(this.val);
}

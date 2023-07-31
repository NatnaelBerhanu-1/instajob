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

class WorkActivityLoaded extends InitialCareerLearning {
  final List<WorkModel> list;

  WorkActivityLoaded(this.list);
}

class KnowledgeLoaded extends InitialCareerLearning {
  final List<WorkModel> list;

  KnowledgeLoaded(this.list);
}

class WorkStyleLoaded extends InitialCareerLearning {
  final List<WorkModel> list;

  WorkStyleLoaded(this.list);
}

class EduLoaded extends InitialCareerLearning {
  final List<ClusterEducationModel> list;

  EduLoaded(this.list);
}

class DetailWorkActivityLoaded extends InitialCareerLearning {
  final List<WorkModel> list;

  DetailWorkActivityLoaded(this.list);
}

class WorkContextLoaded extends InitialCareerLearning {
  final List<WorkModel> list;
  WorkContextLoaded(this.list);
}

class CareerDetailLoaded extends InitialCareerLearning {
  final List<ClusterDetailsModel> list;

  CareerDetailLoaded(this.list);
}

class DetailLoaded extends InitialCareerLearning {
  final CareerClusterModel data;

  DetailLoaded(this.data);
}

class JobZoneLoaded extends InitialCareerLearning {
  final JobZoneModel data;

  JobZoneLoaded(this.data);
}

class CareerErrorState extends InitialCareerLearning {
  final String error;

  CareerErrorState(this.error);
}

class DropDownState extends InitialCareerLearning {
  final CareerClusterModel val;

  DropDownState(this.val);
}

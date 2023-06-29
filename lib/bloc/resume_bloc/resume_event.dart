import 'package:equatable/equatable.dart';
import 'package:insta_job/model/cover_letter_model.dart';
import 'package:insta_job/model/resume_model.dart';

abstract class ResumeEvent extends Equatable {}

class AddResumeEvent extends ResumeEvent {
  final CoverLetterModel coverLetterModel;

  AddResumeEvent(this.coverLetterModel);
  @override
  List<Object?> get props => [];
}

class LoadResumeEvent extends ResumeEvent {
  final String id;

  LoadResumeEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class TellMeAbtYourSelfEvent extends ResumeEvent {
  final String data;

  TellMeAbtYourSelfEvent(this.data);
  @override
  List<Object?> get props => [data];
}

class AddEducationEvent extends ResumeEvent {
  final Educations educationModel;

  AddEducationEvent(this.educationModel);
  @override
  List<Object?> get props => [educationModel];
}

class AddWorkExpEvent extends ResumeEvent {
  final WorkExperiences workExpModel;

  AddWorkExpEvent(this.workExpModel);
  @override
  List<Object?> get props => [workExpModel];
}

class AddSkillsEvent extends ResumeEvent {
  final List<String> skills;

  AddSkillsEvent(this.skills);
  @override
  List<Object?> get props => [skills];
}

class AddAchievementEvent extends ResumeEvent {
  final List<String> ach;

  AddAchievementEvent(this.ach);
  @override
  List<Object?> get props => [ach];
}

class UserResumeLoadedEvent extends ResumeEvent {
  final String? userId;

  UserResumeLoadedEvent({this.userId});
  @override
  List<Object?> get props => [];
}

class DeleteEducation extends ResumeEvent {
  final int? index;
  final String? id;

  DeleteEducation({this.id, this.index});
  @override
  List<Object?> get props => [];
}

class DeleteWorkExp extends ResumeEvent {
  final int? index;
  final String? id;
  DeleteWorkExp({this.id, this.index});
  @override
  List<Object?> get props => [];
}

/*class CheckReadOnlyEvent extends ResumeEvent {
  final bool readOnly;

  CheckReadOnlyEvent(this.readOnly);
  @override
  List<Object?> get props => [];
}

class CheckIsConfirmEvent extends ResumeEvent {
  final bool isConfirm;

  CheckIsConfirmEvent(this.isConfirm);
  @override
  List<Object?> get props => [];
}*/

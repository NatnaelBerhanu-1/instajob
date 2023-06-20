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
  final ResumeModel resumeModel;
  final bool isNew;

  AddEducationEvent(this.resumeModel, {this.isNew = false});
  @override
  List<Object?> get props => [resumeModel, isNew];
}

class AddWorkExpEvent extends ResumeEvent {
  final ResumeModel resumeModel;
  final bool isNew;

  AddWorkExpEvent(this.resumeModel, {this.isNew = false});
  @override
  List<Object?> get props => [resumeModel];
}

class AddSkillsEvent extends ResumeEvent {
  final List<String> skills;

  AddSkillsEvent(this.skills);
  @override
  List<Object?> get props => [skills];
}

class DeleteEducation extends ResumeEvent {
  final int index;

  DeleteEducation(this.index);
  @override
  List<Object?> get props => [];
}

class DeleteWorkExp extends ResumeEvent {
  final int index;

  DeleteWorkExp(this.index);
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

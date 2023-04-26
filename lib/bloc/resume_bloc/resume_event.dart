import 'package:equatable/equatable.dart';
import 'package:insta_job/model/resume_model.dart';

abstract class ResumeEvent extends Equatable {}

class AddResumeEvent extends ResumeEvent {
  final ResumeModel resumeModel;

  AddResumeEvent(this.resumeModel);
  @override
  List<Object?> get props => [];
}

class LoadResumeEvent extends ResumeEvent {
  final String id;

  LoadResumeEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class CheckReadOnlyEvent extends ResumeEvent {
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
}

import 'package:equatable/equatable.dart';
import 'package:insta_job/model/resume_model.dart';

abstract class ResumeEvent extends Equatable {}

class AddResumeEvent extends ResumeEvent {
  final ResumeModel resumeModel;

  AddResumeEvent(this.resumeModel);
  @override
  List<Object?> get props => [];
}

class InterviewState {}

class IntInitialState extends InterviewState {}

class IntLoading extends InterviewState {}

class IntLoaded extends InterviewState {}

class IntErrorState extends InterviewState {
  final String error;

  IntErrorState(this.error);
}

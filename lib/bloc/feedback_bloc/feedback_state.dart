import 'package:equatable/equatable.dart';

class FeedBackState extends Equatable {
  const FeedBackState();
  @override
  List<Object?> get props => [];
}

class FeedBackInitialState extends FeedBackState {}

class FeedBackLoading extends FeedBackState {}

class FeedBackLoaded extends FeedBackState {}

class ErrorState extends FeedBackState {
  final String error;

  const ErrorState(this.error);
}

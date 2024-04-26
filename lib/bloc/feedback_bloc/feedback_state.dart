import 'package:equatable/equatable.dart';

class FeedBackState extends Equatable {
  const FeedBackState();
  @override
  List<Object?> get props => [];
}

class FeedBackInitialState extends FeedBackState {}

class FeedBackLoading extends FeedBackState {}

class FeedBackLoading2 extends FeedBackState {}

class FeedBackLoaded extends FeedBackState {}

class ErrorState extends FeedBackState {
  final String error;

  const ErrorState(this.error);
}

class AutoMsgState extends FeedBackState {
  final bool? enabled;
  final String? applicationReceivedSubject;
  final String? applicationReceivedContent;
  final String? disqualifiedReviewSubject;
  final String? disqualifiedReviewContent;
  final String? shortlistedReviewSubject;
  final String? shortlistedReviewContent;
  const AutoMsgState({
    required this.enabled,
    required this.applicationReceivedSubject,
    required this.applicationReceivedContent,
    required this.disqualifiedReviewSubject,
    required this.disqualifiedReviewContent,
    required this.shortlistedReviewSubject,
    required this.shortlistedReviewContent,
  });
}

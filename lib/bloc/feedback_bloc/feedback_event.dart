import 'package:equatable/equatable.dart';

abstract class FeedBackEvent extends Equatable {}

class InsertFeedBackEvent extends FeedBackEvent {
  final String feedBack;

  InsertFeedBackEvent(this.feedBack);
  @override
  List<Object?> get props => [feedBack];
}

class InertAutoMsg extends FeedBackEvent {
  final String? applicationReceivedSubject;
  final String? applicationReceivedContent;
  final String? disqualifiedReviewSubject;
  final String? disqualifiedReviewContent;
  final String? shortlistedReviewSubject;
  final String? shortlistedReviewContent;
  final String? autoButton;
  // final String? empId;

  InertAutoMsg({
    this.applicationReceivedSubject,
    this.applicationReceivedContent,
    this.disqualifiedReviewSubject,
    this.disqualifiedReviewContent,
    this.shortlistedReviewSubject,
    this.shortlistedReviewContent,
    this.autoButton,
    // this.empId,
  });
  @override
  List<Object?> get props => [];
}

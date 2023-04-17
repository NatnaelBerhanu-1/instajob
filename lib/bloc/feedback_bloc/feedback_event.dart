import 'package:equatable/equatable.dart';

abstract class FeedBackEvent extends Equatable {}

class InsertFeedBackEvent extends FeedBackEvent {
  final String feedBack;

  InsertFeedBackEvent(this.feedBack);
  @override
  List<Object?> get props => [feedBack];
}

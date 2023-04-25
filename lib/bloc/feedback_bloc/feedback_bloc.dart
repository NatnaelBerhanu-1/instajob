import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_event.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_state.dart';
import 'package:insta_job/repository/feed_back.dart';

class FeedBackBloc extends Bloc<FeedBackEvent, FeedBackState> {
  final FeedBackRepository feedBackRepository;
  FeedBackBloc(this.feedBackRepository) : super(FeedBackInitialState()) {
    on<InsertFeedBackEvent>((event, emit) async {
      emit(FeedBackLoading());
      await feedBackRepository.insertFeedBack(feedBack: event.feedBack);
      emit(FeedBackLoaded());
    });
  }
}

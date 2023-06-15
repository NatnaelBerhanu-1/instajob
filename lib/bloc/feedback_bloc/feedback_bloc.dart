import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_event.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/feed_back.dart';

class FeedBackAndAutoMsgBloc extends Bloc<FeedBackEvent, FeedBackState> {
  final FeedBackRepository feedBackRepository;
  FeedBackAndAutoMsgBloc(this.feedBackRepository)
      : super(FeedBackInitialState()) {
    on<InsertFeedBackEvent>((event, emit) async {
      emit(FeedBackLoading());
      ApiResponse response =
          await feedBackRepository.insertFeedBack(feedBack: event.feedBack);
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        showToast("Feedback sent successfully");
        emit(FeedBackLoaded());
      } else if (response.response.statusCode == 400) {}
    });

    on<InertAutoMsg>((event, emit) async {
      ApiResponse response = await feedBackRepository.autoMessage();
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
      } else if (response.response.statusCode == 400) {}
    });
  }
}

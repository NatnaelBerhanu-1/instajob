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
      emit(FeedBackLoading2());
      ApiResponse response = await feedBackRepository.autoMessage(
        applicationReceivedSubject: event.applicationReceivedSubject,
        applicationReceivedContent: event.applicationReceivedContent,
        disqualifiedReviewSubject: event.disqualifiedReviewSubject,
        disqualifiedReviewContent: event.disqualifiedReviewContent,
        shortlistedReviewSubject: event.shortlistedReviewSubject,
        shortlistedReviewContent: event.shortlistedReviewContent,
        autoButton: event.autoButton,
        // empId: event.empId,
      );
      if (response.response.statusCode == 500) {
        emit(const ErrorState("Something went wrong"));
      }
      if (response.response.statusCode == 200) {
        emit(AutoMsgState(
          enabled: event.autoButton == "0" ? false : true,
          applicationReceivedSubject: event.applicationReceivedSubject,
          applicationReceivedContent: event.applicationReceivedContent,
          disqualifiedReviewSubject: event.disqualifiedReviewSubject,
          disqualifiedReviewContent: event.disqualifiedReviewContent,
          shortlistedReviewSubject: event.shortlistedReviewSubject,
          shortlistedReviewContent: event.shortlistedReviewContent,
        ));

        if (event.autoButton == "0") {
          //disabled
          Global.userModel?.automateMsgBtn = 0;
          Global.userModel?.applicationReceivedContent = "";
          Global.userModel?.applicationReceivedSubject = "";
          Global.userModel?.disqualifiedReviewSubject = "";
          Global.userModel?.disqualifiedReviewContent = "";
          Global.userModel?.shortlistedReviewSubject = "";
          Global.userModel?.shortlistedReviewContent = "";
        } else if (event.autoButton == "1") {
          Global.userModel?.automateMsgBtn = 1;
          Global.userModel?.applicationReceivedContent =
              event.applicationReceivedContent;
          Global.userModel?.applicationReceivedSubject =
              event.applicationReceivedSubject;
          Global.userModel?.disqualifiedReviewSubject =
              event.disqualifiedReviewSubject;
          Global.userModel?.disqualifiedReviewContent =
              event.disqualifiedReviewContent;
          Global.userModel?.shortlistedReviewSubject =
              event.shortlistedReviewSubject;
          Global.userModel?.shortlistedReviewContent =
              event.shortlistedReviewContent;
        }
      } else if (response.response.statusCode == 400) {
        emit(const ErrorState("Not Found"));
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/generated_questions/get_generated_initial_questions_state.dart';
import 'package:insta_job/bloc/generated_questions/temp.dart';
import 'package:insta_job/model/ai_questions_data_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/ai_questions_repository.dart';

class GetGeneratedInitialQuestionsCubit
    extends Cubit<GetGeneratedInitialQuestionsState> {
  final AiQuestionsRepository aiQuestionsRepository;
  GetGeneratedInitialQuestionsCubit(this.aiQuestionsRepository)
      : super(GetGeneratedInitialQuestionsInitialState());

  Future<void> execute(
      {required String? cvUrl, required String? jobDescription}) async {
    print("LOGG abt to start loading");
    emit(const GetGeneratedInitialQuestionsLoading());
    await Future.delayed(const Duration(seconds: 3));
    print("LOGG finished loading");
    try {
      // var x = mockJson;
      // AiQuestionsModel res = AiQuestionsModel.fromJson(x);

      ApiResponse response = await aiQuestionsRepository.getInitialQuestions(
          cvUrl: cvUrl, jobDescription: jobDescription);
      if (response.response.statusCode == 500) {
        emit(const GetGeneratedInitialQuestionsErrorState(
            message: 'Something went wrong'));
      }
      if (response.response.statusCode == 200) {
        // debugPrint('response ${response.response.data['data']}');
        debugPrint('LOGG response 200');
        // List<JobPosModel> list = (response.response.data['data'] as List)
        //     .map((e) => JobPosModel.fromJson(e).copyWith(jobId: jobId))
        //     .toList();
        // List<AiQuestionsModel> list = (response.response.data['questions'] as List)
        //     .map((e) => JobPosModel.fromJson(e).copyWith(jobId: jobId))
        //     .toList();
        var x = response.response;
        print("LOGG sth $x");
        AiQuestionsModel res = AiQuestionsModel.fromJson(response.response);
        emit(GetGeneratedInitialQuestionsLoaded(
          aiQuestionsModel: res,
        ));
      } else if (response.response.statusCode == 400) {
        emit(const GetGeneratedInitialQuestionsErrorState(
            message: "Data Not Found"));
      } else {
        emit(const GetGeneratedInitialQuestionsErrorState(
            message: 'Something went wrong'));
      }
      emit(GetGeneratedInitialQuestionsLoaded(
        aiQuestionsModel: response.response,
      ));
    } catch (e) {
      emit(const GetGeneratedInitialQuestionsErrorState(
          message: 'Something went wrong'));
    }
  }


  
  // Future<void> execute(
  //     {required String? cvUrl, required String? jobDescription}) async {
  //   print("LOGG abt to start loading");
  //   emit(const GetGeneratedInitialQuestionsLoading());
  //   await Future.delayed(const Duration(seconds: 3));
  //   print("LOGG finished loading");
  //   try {
  //     var x = mockJson;
  //     AiQuestionsModel res = AiQuestionsModel.fromJson(x);
  //     emit(GetGeneratedInitialQuestionsLoaded(
  //       aiQuestionsModel: res,
  //     ));
  //   } catch (e) {
  //     emit(const GetGeneratedInitialQuestionsErrorState(
  //         message: 'Something went wrong'));
  //   }
  // }
}

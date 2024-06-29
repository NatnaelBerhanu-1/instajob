import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:insta_job/model/ai_questions_data_model.dart';

class GetGeneratedInitialQuestionsState extends Equatable {
  const GetGeneratedInitialQuestionsState();
  @override
  List<Object?> get props => [];
}

class GetGeneratedInitialQuestionsInitialState extends GetGeneratedInitialQuestionsState {}

class GetGeneratedInitialQuestionsLoading extends GetGeneratedInitialQuestionsState {
  const GetGeneratedInitialQuestionsLoading();
}

class GetGeneratedInitialQuestionsLoaded extends GetGeneratedInitialQuestionsState {
  final AiQuestionsModel aiQuestionsModel;

  const GetGeneratedInitialQuestionsLoaded({
    required this.aiQuestionsModel,
  });

  @override
  List<Object?> get props => [aiQuestionsModel, Random()];
}

class GetGeneratedInitialQuestionsErrorState extends GetGeneratedInitialQuestionsState {
  final String message;

  const GetGeneratedInitialQuestionsErrorState({
    required this.message,
  });
}

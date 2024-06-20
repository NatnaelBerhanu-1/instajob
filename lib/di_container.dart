import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:insta_job/bloc/agora_bloc/agora_cubit.dart';
import 'package:insta_job/bloc/attachment_download_cubit/attachment_download_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/banking_info_bloc/add_banking_info/add_banking_info_cubit.dart';
import 'package:insta_job/bloc/cancel_interview_schedule_cubit/cancel_interview_schedule_cubit.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/end_interview_call_cubit/end_interview_call_cubit.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_bloc.dart';
import 'package:insta_job/bloc/get_declined_job_position/get_denied_job_poision_bloc.dart';
import 'package:insta_job/bloc/get_hired_job_position/get_hired_candidates_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/interview_cubit/interview_cubit.dart';
import 'package:insta_job/bloc/interview_recording_cubit/interview_recording_cubit.dart';
import 'package:insta_job/bloc/interview_schedule_cubit/interview_schedule_cubit.dart';
import 'package:insta_job/bloc/interview_transcription_cubit/interview_transcription_cubit.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/location_cubit/location_cubit.dart';
import 'package:insta_job/bloc/mask_resumes_cubit/mask_resumes_cubit.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_details_cubit/resume_details_cubit.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/repository/attachment_download_repository.dart';
import 'package:insta_job/repository/auth_repository.dart';
import 'package:insta_job/repository/banking_info_repository.dart';
import 'package:insta_job/repository/career_learning_repo.dart';
import 'package:insta_job/repository/company_repo.dart';
import 'package:insta_job/repository/feed_back.dart';
import 'package:insta_job/repository/interview_repo.dart';
import 'package:insta_job/repository/job_position_repo.dart';
import 'package:insta_job/repository/mask_resumes_repository.dart';
import 'package:insta_job/repository/resume_repo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bottom_bloc/bottom_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(
    () => DioClient(
        sharedPreferences: sl(), baseUrl: EndPoint.baseUrl, dioC: sl()),
  );

  /// repo
  sl.registerLazySingleton(() => AuthRepository(dioClient: sl()));
  sl.registerLazySingleton(() => CompanyRepository(sl()));
  sl.registerLazySingleton(() => JobPositionRepository(dioClient: sl()));
  sl.registerLazySingleton(() => FeedBackRepository(dioClient: sl()));
  sl.registerLazySingleton(() => ResumeRepository(dioClient: sl()));
  sl.registerLazySingleton(() => CareerLearningRepo(sl()));
  sl.registerLazySingleton(() => InterviewRepo(dioClient: sl()));
  sl.registerLazySingleton(() => AttachmentDownloadRepository(dioClient: sl()));
  sl.registerLazySingleton(() => MaskResumesRepository(dioClient: sl()));
  sl.registerLazySingleton(() => BankingInfoRepo(dioClient: sl()));

  /// cubit
  sl.registerLazySingleton(() => GlobalCubit());
  sl.registerLazySingleton(() => ValidationCubit());
  sl.registerLazySingleton(() => PickImageCubit(sl()));

  ///   bloc
  sl.registerLazySingleton(() =>
      AuthCubit(sl(), sl(), authRepository: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => CompanyBloc(sl()));
  sl.registerLazySingleton(() => BottomBloc()..add(UserEvent()));
  sl.registerLazySingleton(() => JobPositionBloc(sl()));
  sl.registerLazySingleton(() => FeedBackAndAutoMsgBloc(sl()));
  sl.registerLazySingleton(() => ResumeBloc(sl()));
  sl.registerLazySingleton(() => LocationCubit(sl()));
  // sl.registerLazySingleton(() => AgoraBloc());
  sl.registerLazySingleton(() => CareerLearningBloc(sl()));
  sl.registerLazySingleton(() => InterviewCubit(sl()));
  sl.registerLazySingleton(() => AttachmentDownloadCubit(sl()));
  sl.registerLazySingleton(() => MaskResumesCubit(sl()));
  sl.registerLazySingleton(() => InterviewScheduleCubit(sl()));
  sl.registerLazySingleton(() => CancelInterviewScheduleCubit(sl()));
  sl.registerLazySingleton(() => ResumeDetailsCubit(sl()));
  sl.registerLazySingleton(() => GetDeniedJobPositionCubit(sl()));
  sl.registerLazySingleton(() => InterviewRecordingCubit(sl()));
  sl.registerLazySingleton(() => EndInterviewCallScheduleCubit(sl()));
  sl.registerLazySingleton(() => InterviewTranscriptionCubit(sl()));
  sl.registerLazySingleton(() => GetHiredCandidatesCubit(sl()));
  sl.registerLazySingleton(() => AddBankingInfoCubit(sl()));

  /// other
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => preferences);
  sl.registerLazySingleton(() => PrettyDioLogger());
}

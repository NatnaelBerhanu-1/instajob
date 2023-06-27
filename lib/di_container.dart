import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/location_cubit/location_cubit.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/repository/auth_repository.dart';
import 'package:insta_job/repository/company_repo.dart';
import 'package:insta_job/repository/feed_back.dart';
import 'package:insta_job/repository/job_position_repo.dart';
import 'package:insta_job/repository/resume_repo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bottom_bloc/bottom_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(
    () => DioClient(
        baseUrl: EndPoint.baseUrl, sharedPreferences: sl(), dioC: sl()),
  );

  /// repo
  sl.registerLazySingleton(() => AuthRepository(dioClient: sl()));
  sl.registerLazySingleton(() => CompanyRepository(dioClient: sl()));
  sl.registerLazySingleton(() => JobPositionRepository(dioClient: sl()));
  sl.registerLazySingleton(() => FeedBackRepository(dioClient: sl()));
  sl.registerLazySingleton(() => ResumeRepository(dioClient: sl()));

  /// cubit
  sl.registerLazySingleton(() => GlobalCubit());
  sl.registerLazySingleton(() => ValidationCubit());
  sl.registerLazySingleton(() => PickImageCubit(sl()));

  ///   bloc
  sl.registerLazySingleton(() =>
      AuthCubit(sl(), sl(), authRepository: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => CompanyBloc(sl()));
  sl.registerLazySingleton(() => BottomBloc(sl())..add(UserEvent()));
  sl.registerLazySingleton(() => JobPositionBloc(sl()));
  sl.registerLazySingleton(() => FeedBackAndAutoMsgBloc(sl()));
  sl.registerLazySingleton(() => ResumeBloc(sl()));
  sl.registerLazySingleton(() => LocationCubit(sl()));

  /// other
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => preferences);
  sl.registerLazySingleton(() => PrettyDioLogger());
}

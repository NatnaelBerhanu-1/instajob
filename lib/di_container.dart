import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/global_bloc.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/provider/bottom_provider.dart';
import 'package:insta_job/repository/auth_repository.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(
    () => DioClient(
        baseUrl: EndPoint.baseUrl, sharedPreferences: sl(), dioC: sl()),
  );
  sl.registerLazySingleton(() => AuthRepository(dioClient: sl()));

  /// provides
  sl.registerLazySingleton(() => BottomProvider());
  sl.registerLazySingleton(() => IndexBloc());

  ///   bloc
  sl.registerLazySingleton(
      () => AuthCubit(authRepository: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ValidationCubit());

  /// other
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => preferences);
  sl.registerLazySingleton(() => PrettyDioLogger());
}

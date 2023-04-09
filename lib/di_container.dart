import 'package:get_it/get_it.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/network/dio/dio_client.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/repository/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(
    () => DioClient(
        baseUrl: EndPoint.baseUrl, sharedPreferences: sl(), dioC: sl()),
  );
  sl.registerLazySingleton(() => AuthRepository(dioClient: sl()));
  sl.registerLazySingleton(() => AuthCubit(
        authRepository: sl(),
        sharedPreferences: sl(),
      ));
}

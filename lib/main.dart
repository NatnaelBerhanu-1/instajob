// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/bloc_providers.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/provider/bottom_provider.dart';
import 'package:insta_job/screens/insta_job_user/bottom_nav_screen/user_account/occupation_details_screen.dart';
import 'package:insta_job/screens/insta_recruit/splash_screen.dart';
import 'package:provider/provider.dart';

import 'bloc/global_bloc.dart';
import 'utils/my_colors.dart';
import 'di_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => di.sl<AuthCubit>())],
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => BottomProvider())],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: MyColors.white,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
          ),
          home: SplashScreen(),
          navigatorKey: navigationKey,
        ),
      ),
    );
  }
}

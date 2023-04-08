// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/screens/insta_recruit/splash_screen.dart';

import 'bloc/global_cubit/global_cubit.dart';
import 'utils/my_colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GlobalCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.white,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

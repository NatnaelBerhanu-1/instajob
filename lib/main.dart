// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/changeValue_bloc.dart';
import 'package:insta_job/screens/insta_recruit/home_page.dart';

import 'utils/my_colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => IndexBloc())],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.white,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        home: HomePage(
            // isUserInterface: true,
            ),
      ),
    );
  }
}

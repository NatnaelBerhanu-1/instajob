// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/screens/bottom_navigation_screen/search_pages/job_position_screen.dart';

import 'utils/my_colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      home: JobPositionScreen(),
    );
  }
}

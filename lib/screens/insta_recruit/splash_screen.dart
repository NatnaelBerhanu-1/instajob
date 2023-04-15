// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';
import '../../utils/app_routes.dart';
import '../../widgets/custom_cards/custom_common_card.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    var pref = await SharedPreferences.getInstance();

    if (currentUser != null) {
      var user = await jsonDecode(pref.getString("user").toString());
      UserModel userModel = UserModel.fromJson(user);
      Global.userModel = userModel;
      print('USERMODEL ---------------        $user');
      context.read<CompanyBloc>().add(LoadCompanyListEvent());
      context.read<JobPositionBloc>().add(LoadJobPosListEvent());
      Timer(Duration(seconds: 1),
          () => AppRoutes.pushAndRemoveUntil(context, BottomNavScreen()));
    } else {
      Timer(
          Duration(seconds: 1),
          () => Navigator.push(
              context, SlideRightRoute(widget: UserTypeScreen())));
    }
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MyColors.blue,
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0, bottom: 15),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImages.bg), fit: BoxFit.cover)),
            child: Center(
              child: GestureDetector(
                onVerticalDragStart: (val) {
                  // AppRoutes.push(context, UserTypeScreen());
                  checkUser();
                  // Navigator.push(
                  //     context, SlideRightRoute(widget: UserTypeScreen()));
                },
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    CommonText(
                      text: "Welcome",
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    // SizedBox(height: 20),
                    // Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset(
                        MyImages.logo,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Image.asset(
                      MyImages.instaJobLogo,
                      fit: BoxFit.cover,
                    ),
                    // Spacer(),
                    Spacer(),
                    ImageButton(
                      image: MyImages.startArrow,
                      padding: EdgeInsets.zero,
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 10),
                    CommonText(
                      text: "Get Started",
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      fontColor: MyColors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
import 'package:insta_job/bloc/location_cubit/location_cubit.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';

import '../../widgets/custom_cards/custom_common_card.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  permission() async {
    if (userType == "user") {
      await context.read<LocationCubit>().getCurrentLocation();
    }
    context.read<BottomBloc>().add(UserEvent());

    // }
  }

  @override
  initState() {
    permission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // checkUser();
                  // Navigator.push(
                  //     context, SlideRightRoute(widget: UserTypeScreen()));
                  context.read<BottomBloc>().add(UserEvent());
                },
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    CommonText(
                      text: "Welcome",
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
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
                    Spacer(),
                    ImageButton(
                      image: MyImages.startArrow,
                      padding: EdgeInsets.zero,
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 15),
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

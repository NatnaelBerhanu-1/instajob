// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/user_model.dart';
import 'package:insta_job/screens/auth_screen/login_screen.dart';
import 'package:insta_job/screens/auth_screen/register_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/helpers.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_all_small_button.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';

import '../../bloc/auth_bloc/auth_state.dart';
import '../../utils/my_colors.dart';
import 'user_type_screen.dart';

class WelcomeScreen extends StatelessWidget {
  Function(BuildContext context)? onBackPressed;
  WelcomeScreen({Key? key, this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MyColors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 240,
                // color: MyColors.blue,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 60,
                      child: Image.asset(
                        MyImages.bgCurve,
                        color: MyColors.grey.withOpacity(.10),
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        MyImages.welcomeLogo,
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.35,
                        // width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 45,
                      left: 15,
                      child: ImageButton(
                        image: MyImages.backArrow,
                        height: 30,
                        width: 30,
                        onTap: onBackPressed != null ? () => onBackPressed!.call(context) : () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          AppRoutes.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 20),
              Center(child: Image.asset(MyImages.instaLogo_)),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CommonText(
                        text: "Employ instantly",
                        fontColor: MyColors.grey,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 50),
                    CommonText(
                      text: "Welcome",
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    SizedBox(height: 5),
                    CommonText(
                      text: "Login in to your existing account or register to make new\naccount.",
                      fontWeight: FontWeight.w400,
                      fontColor: MyColors.grey,
                      fontSize: 13,
                    ),
                    SizedBox(height: 30),
                    CustomIconButton(
                      image: MyImages.arrowWhite,
                      title: "Sign in",
                      onclick: () {
                        AppRoutes.push(context, LoginScreen());
                      },
                    ),
                    SizedBox(height: 20),
                    CustomIconButton(
                      image: MyImages.arrowWhite,
                      title: "Register Now",
                      backgroundColor: MyColors.white,
                      fontColor: MyColors.black,
                      borderColor: MyColors.blue,
                      iconColor: MyColors.blue,
                      onclick: () {
                        AppRoutes.push(context, RegisterScreen());
                      },
                    ),
                    if(userType == "user") ...[SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: (){
                          // Navigate to home page
                          Global.userModel = UserModel(type: "user");
                          context.read<GlobalCubit>().changeIndex(1);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavScreen()));
                          
                        },
                        child: Text("Continue as Guest", textAlign: TextAlign.center, style: TextStyle(decoration: TextDecoration.underline),))),],
                    SizedBox(height: 30),
                    CustomDivider(),
                    SizedBox(height: 30),
                    BlocConsumer<AuthCubit, AuthInitialState>(listener: (context, state) {
                      if (state is ErrorState) {
                        showToast(state.error);
                      }
                    }, builder: (context, state) {
                      var auth = context.read<AuthCubit>();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if(Platform.isIOS) CustomSocialButton(
                            image: MyImages.apple,
                            onTap: () {
                              auth.appleAuth(context);
                            },
                          ),
                          CustomSocialButton(
                            image: MyImages.google,
                            onTap: () {
                              auth.googleAuth(context);
                            },
                          ),
                          CustomSocialButton(
                            image: MyImages.twitter,
                            onTap: () async {
                              await auth.signInWithTwitter(isUser: userType == "user" ? true : false);
                            },
                          ),
                          // CustomSocialButton(
                          //   image: MyImages.facebook,
                          //   onTap: () {
                          //     // showToast("Currently Not Working");
                          //     auth.faceBookAuth(context, isUser: userType == "user" ? true : false);
                          //   },
                          // ),
                        ],
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImages.bg), fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomCommonText(
                    text: "Welcome",
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Image.asset(
                    MyImages.logo,
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: UserTypeCard()),
                    Expanded(child: UserTypeCard()),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      Image.asset(MyImages.instaLogo_),
                      CustomCommonText(
                        text: "Employee instantly",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );*/

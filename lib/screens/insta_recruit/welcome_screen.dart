// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/auth_screen/login_screen.dart';
import 'package:insta_job/screens/auth_screen/register_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
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
  const WelcomeScreen({Key? key}) : super(key: key);

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
                height: 340,
                // color: MyColors.blue,
                child: Stack(
                  children: [
                   GestureDetector(
                     onTap: (){
                       log('0000');
                       Navigator.pop(context);
                     },
                     child: Padding(
                       padding: const EdgeInsets.only(top: 35,left: 5),
                       child: Image.asset(MyImages.backArrow,height: 40,),
                     ),
                   ),
                    Image.asset(
                      MyImages.bgCurve,
                      color: MyColors.grey.withOpacity(.10),
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                      top: 80,
                      child: Image.asset(
                        MyImages.welcomeLogo,
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 20),
              Center(child: Image.asset(MyImages.instaLogo_)),
              Padding(
                padding:
                    const EdgeInsets.only(right: 15.0, left: 15, bottom: 10),
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
                      text:
                          "Login in to your existing account or register to make new\naccount.",
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
                    SizedBox(height: 30),
                    CustomDivider(),
                    SizedBox(height: 30),
                    BlocConsumer<AuthCubit, AuthInitialState>(
                        listener: (context, state) {
                      if (state is ErrorState) {
                        showToast(state.error);
                      }
                    }, builder: (context, state) {
                      var auth = context.read<AuthCubit>();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomSocialButton(
                            image: MyImages.google,
                            onTap: () {
                              print("@@@@@@@@@@ $userType");
                              auth.googleAuth(context);
                            },
                          ),
                          CustomSocialButton(
                            image: MyImages.twitter,
                            onTap: () {
                              showToast("Currently Not Working");
                            },
                          ),
                          CustomSocialButton(
                            image: MyImages.facebook,
                            onTap: () {
                              // showToast("Currently Not Working");
                              auth.faceBookAuth(
                                  isUser: userType == "user" ? true : false);
                            },
                          ),
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

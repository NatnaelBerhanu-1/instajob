// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/auth_screen/forgot_password.dart';
import 'package:insta_job/screens/auth_screen/register_screen.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';
import 'package:insta_job/screens/insta_recruit/welcome_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_chip.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../bloc/auth_bloc/auth_cubit.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../../bloc/auth_bloc/social_auth/social_auth.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_images.dart';
import '../../widgets/custom_button/custom_all_small_button.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_cards/custom_common_card.dart';
import '../../widgets/custom_divider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        return true;
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            MyImages.bgCurve,
                            color: MyColors.grey.withOpacity(.10),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageButton(
                                  image: MyImages.backArrow,
                                  height: 30,
                                  width: 30,
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    AppRoutes.pushAndRemoveUntil(
                                        context, WelcomeScreen());
                                  },
                                ),
                                SizedBox(width: 50),
                                Column(
                                  children: [
                                    Image.asset(MyImages.instaLogo_),
                                    CommonText(
                                      text: "Employ instantly",
                                      fontColor: MyColors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: BlocBuilder<ValidationCubit, InitialValidation>(
                          builder: (context, state) {
                        var validationBloc = context.read<ValidationCubit>();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome,",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Enter your login details to access your account",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: MyColors.grey,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 30),
                            IconTextField(
                              controller: email,
                              prefixIcon: ImageButton(
                                image: MyImages.email,
                                padding: EdgeInsets.all(13),
                                height: 10,
                                width: 10,
                              ),
                              suffixIcon: validationBloc.emailVAL
                                  ? verifyImage
                                  : SizedBox(),
                              validator: (val) => emailValidation(val!),
                              onChanged: (val) {
                                if (!formKey.currentState!.validate()) {
                                  emailValidation(val!);
                                  // validationBloc.emailCheck(
                                  //     formKey.currentState?.validate());
                                }
                              },
                              hint: "alexis@mygmail.com",
                            ),
                            SizedBox(height: 15),
                            IconTextField(
                              controller: password,
                              prefixIcon: ImageButton(
                                image: MyImages.lock,
                                padding: EdgeInsets.all(13),
                                height: 10,
                                width: 10,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  validationBloc.visiblePass();
                                },
                                child: Icon(
                                  validationBloc.pass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              obscureText: validationBloc.pass,
                              hint: "password",
                              maxLine: 1,
                              validator: (val) => passwordValidation(val!),
                              onChanged: (val) {
                                if (!formKey.currentState!.validate()) {
                                  passwordValidation(val!);
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            CustomGesture(
                              onTap: () {
                                AppRoutes.push(context, ForgotPassword());
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.blue,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            BlocConsumer<AuthCubit, AuthInitialState>(
                                listener: (context, state) {
                              if (state is ErrorState) {
                                showToast(state.error);
                              }
                            }, builder: (context, state) {
                              return CustomIconButton(
                                image: MyImages.arrowWhite,
                                title: "Sign In Now",
                                backgroundColor: MyColors.blue,
                                fontColor: MyColors.white,
                                loading:
                                    state is AuthLoadingState ? true : false,
                                borderColor: MyColors.blue,
                                iconColor: MyColors.white,
                                onclick: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (formKey.currentState!.validate()) {
                                    if (userType == "user") {
                                      SocialAuth.loginWithEmail(context,
                                          email: email.text,
                                          password: password.text,
                                          isUser: true);
                                    } else {
                                      SocialAuth.loginWithEmail(context,
                                          email: email.text,
                                          password: password.text);
                                    }
                                  }
                                  // if (Global.type == "user") {
                                  //   AppRoutes.pushAndRemoveUntil(
                                  //       context, MemberShipScreen());
                                  // } else {
                                  //   AppRoutes.pushAndRemoveUntil(
                                  //       context, BottomNavScreen());
                                  // }
                                },
                              );
                            }),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomSocialButton(
                                    image: MyImages.google,
                                    onTap: () async {
                                      await auth.googleAuth(
                                          isUser: userType == "user"
                                              ? true
                                              : false);
                                    },
                                  ),
                                  CustomSocialButton(image: MyImages.twitter),
                                  CustomSocialButton(image: MyImages.facebook),
                                ],
                              );
                            })
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/* Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(MyImages.bgCurve))),
      ),*/

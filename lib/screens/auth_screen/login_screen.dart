// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/auth_screen/forgot_password.dart';
import 'package:insta_job/screens/auth_screen/register_screen.dart';
import 'package:insta_job/screens/insta_recruit/welcome_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_chip.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        return true;
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
          decoration: BoxDecoration(
              image: DecorationImage(
            alignment: Alignment.topCenter,
            colorFilter: ColorFilter.mode(MyColors.grey.withOpacity(.10), BlendMode.srcIn),
            image: AssetImage(
              MyImages.bgCurve,
            ),
            fit: BoxFit.fitWidth,
          )),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Column(
                  children: [
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
                              FocusManager.instance.primaryFocus?.unfocus();
                              AppRoutes.pop(context);
                            },
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Image.asset(MyImages.instaLogo_),
                              CommonText(
                                text: "Employ instantly",
                                fontColor: MyColors.grey,
                              ),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            width: 50,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: BlocBuilder<ValidationCubit, InitialValidation>(builder: (context, state) {
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
                            SizedBox(height: 20),
                            IconTextField(
                              controller: email,
                              prefixIcon: ImageButton(
                                image: MyImages.email,
                                padding: EdgeInsets.all(13),
                                height: 10,
                                width: 10,
                              ),
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                              suffixIcon: validationBloc.emailVAL ? verifyImage : SizedBox(),
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
                                  validationBloc.pass ? Icons.visibility_off : Icons.visibility,
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
                            SizedBox(height: 30),
                            BlocConsumer<AuthCubit, AuthInitialState>(listener: (context, state) {
                              if (state is ErrorState) {
                                showToast(state.error);
                              }
                            }, builder: (context, state) {
                              return CustomIconButton(
                                image: MyImages.arrowWhite,
                                title: "Sign In Now",
                                backgroundColor: MyColors.blue,
                                fontColor: MyColors.white,
                                loading: state is AuthLoadingState ? true : false,
                                borderColor: MyColors.blue,
                                iconColor: MyColors.white,
                                onclick: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  // if (formKey.currentState!.validate()) {
                                  //   var pref = await SharedPreferences.getInstance();
                                  //   var type = pref.getString("type");

                                  //   if (type == "user") {
                                  //     SocialAuth.loginWithEmail(context,
                                  //         email: email.text, password: password.text, isUser: true);
                                  //   } else {
                                  //     SocialAuth.loginWithEmail(context, email: email.text, password: password.text);
                                  //   }
                                  // }
                                  if (formKey.currentState!.validate()) {
                                      SocialAuth.loginWithEmail(context,
                                          email: email.text, password: password.text); //checking isUser inside
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
                                    onTap: () async {
                                      await auth.googleAuth(context);
                                    },
                                  ),
                                  CustomSocialButton(
                                    image: MyImages.twitter,
                                    onTap: () async {
                                      await auth.signInWithTwitter();
                                    },
                                  ),
                                  // CustomSocialButton(
                                  //   image: MyImages.facebook,
                                  //   onTap: () async {
                                  //     await auth.faceBookAuth(context);
                                  //   },
                                  // ),
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

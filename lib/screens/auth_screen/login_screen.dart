// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/auth_bloc/social_auth/social_auth.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/auth_screen/forgot_password.dart';
import 'package:insta_job/screens/auth_screen/register_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../bloc/company_bloc/company_bloc.dart';
import '../../bloc/company_bloc/company_event.dart';
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
    return Scaffold(
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
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(width: 50),
                              Column(
                                children: [
                                  Image.asset(MyImages.instaLogo_),
                                  CommonText(
                                    text: "Employee instantly",
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
                            prefixIcon: ImageButton(image: MyImages.email),
                            // suffixIcon: validationBloc.valid
                            //     ? ImageButton(image: MyImages.verified)
                            //     : Icon(Icons.close, color: MyColors.lightRed),
                            validator: (val) =>
                                validationBloc.emailValidation(val!),
                            onChanged: (val) {
                              // validationBloc.emailValidation(val!);
                            },
                            hint: "alexies@mygmail.com",
                          ),
                          SizedBox(height: 15),
                          IconTextField(
                            controller: password,
                            prefixIcon: ImageButton(image: MyImages.lock),
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
                            validator: (val) =>
                                validationBloc.passwordValidation(val!),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
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
                          BlocConsumer<ValidationCubit, InitialValidation>(
                              listener: (context, state) {
                            if (state is InvalidEmailState) {
                              showToast(state.email);
                            }
                            if (state is InvalidPasswordState) {
                              showToast(state.pass);
                            }
                            if (state is RequiredValidation) {
                              showToast(state.require);
                            }
                          }, builder: (context, state) {
                            // var authCubit = context.read<AuthCubit>();
                            return CustomIconButton(
                              image: MyImages.arrowWhite,
                              title: "Sign In Now",
                              backgroundColor: MyColors.blue,
                              fontColor: MyColors.white,
                              borderColor: MyColors.blue,
                              iconColor: MyColors.white,
                              onclick: () {
                                if (formKey.currentState!.validate()) {
                                  if (Global.type == "user") {
                                    SocialAuth.loginWithEmail(context,
                                        email: email.text,
                                        password: password.text,
                                        isUser: true);
                                  } else {
                                    SocialAuth.loginWithEmail(context,
                                        email: email.text,
                                        password: password.text);
                                  }
                                } else {
                                  print("1111111111");
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
                          BlocConsumer<AuthCubit, AuthInitialState>(
                              listener: (context, state) {
                            if (state is ErrorState) {
                              showToast(state.error);
                            }
                          }, builder: (context, state) {
                            var authCubit = context.read<AuthCubit>();
                            return CustomIconButton(
                              image: MyImages.arrowWhite,
                              title: "Register Now",
                              backgroundColor: MyColors.white,
                              loading: state is AuthLoadingState ? true : false,
                              fontColor: MyColors.black,
                              borderColor: MyColors.blue,
                              iconColor: MyColors.blue,
                              onclick: () {
                                AppRoutes.push(context, RegisterScreen());
                              },
                            );
                          }),
                          SizedBox(height: 30),
                          CustomDivider(),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomSocialButton(image: MyImages.google),
                              CustomSocialButton(image: MyImages.twitter),
                              CustomSocialButton(image: MyImages.facebook),
                            ],
                          )
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
    );
  }
}
/* Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(MyImages.bgCurve))),
      ),*/

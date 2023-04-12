// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/auth_bloc/social_auth/social_auth.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/auth_screen/login_screen.dart';
import 'package:insta_job/screens/insta_recruit/membership_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_button/custom_all_small_button.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../bloc/validation/validation_bloc.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_images.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_button/custom_img_button.dart';
import '../../widgets/custom_cards/custom_common_card.dart';
import '../../widgets/custom_divider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Form(
        key: formKey,
        child: SafeArea(
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
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(MyImages.instaLogo_),
                                CommonText(
                                  text: "Employee instantly",
                                  fontColor: MyColors.grey,
                                ),
                              ],
                            ),
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
                    child: BlocBuilder<GlobalCubit, InitialState>(
                        builder: (context, state) {
                      var validationBloc = context.read<GlobalCubit>();
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
                            "Please Enter More Information",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: MyColors.grey,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 30),
                          IconTextField(
                            controller: name,
                            prefixIcon: ImageButton(image: MyImages.userFilled),
                            validator: (val) =>
                                AppValidation.requiredValidation(val!, "Name"),
                            // validationBloc.requiredValidation(val!, "Name"),
                            // suffixIcon: ImageButton(image: MyImages.verified),
                            hint: "Alexies martan",
                          ),
                          SizedBox(height: 15),
                          IconTextField(
                            controller: email,
                            prefixIcon: ImageButton(image: MyImages.email),
                            validator: (val) =>
                                AppValidation.emailValidation(val!),
                            // suffixIcon: ImageButton(image: MyImages.verified),
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
                            validator: (val) =>
                                AppValidation.passwordValidation(val!),
                            obscureText: validationBloc.pass,
                            hint: "Password",
                            maxLine: 1,
                          ),
                          SizedBox(height: 15),
                          IconTextField(
                            controller: cPassword,
                            prefixIcon: ImageButton(image: MyImages.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                validationBloc.visibleCPass();
                              },
                              child: Icon(
                                validationBloc.cPass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            obscureText: validationBloc.cPass,
                            hint: "Confirm password",
                            maxLine: 1,
                            validator: (val) =>
                                AppValidation.confirmPassValidation(
                                    val!, password.text),
                          ),
                          SizedBox(height: 20),
                          CustomCheckbox(
                            onchanged: (val) {
                              validationBloc.checkBoxValue();
                            },
                            value: validationBloc.checkBox,
                            title: Text.rich(
                              TextSpan(
                                text: "I accept all the ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.grey,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        AppRoutes.push(
                                            context, MemberShipScreen());
                                      },
                                    text: "Terms & Conditions",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.grey,
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: " related to the app",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.grey,
                                        fontSize: 12,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          BlocConsumer<AuthCubit, AuthInitialState>(
                              listener: (context, state) {
                            if (state is ErrorState) {
                              showToast(state.error);
                            }
                          }, builder: (context, snapshot) {
                            var authCubit = context.read<AuthCubit>();
                            return CustomIconButton(
                              image: MyImages.arrowWhite,
                              title: "Register",
                              backgroundColor: MyColors.blue,
                              fontColor: MyColors.white,
                              borderColor: MyColors.blue,
                              iconColor: MyColors.white,
                              loading: state is AuthLoadingState ? true : false,
                              onclick: () {
                                if (formKey.currentState!.validate()) {
                                  if (validationBloc.checkBox) {
                                    if (Global.type == "user") {
                                      SocialAuth.emailAndPass(context,
                                          name: name.text,
                                          email: email.text,
                                          password: password.text,
                                          isUser: true);
                                    } else {
                                      SocialAuth.emailAndPass(context,
                                          name: name.text,
                                          email: email.text,
                                          password: password.text);
                                    }
                                    // context
                                    //     .read<CompanyBloc>()
                                    //     .add(LoadCompanyListEvent());
                                  } else {
                                    showToast(
                                        "Please accept terms & conditions");
                                  }
                                } else {
                                  print('@@@@@@@@@@@@@@@@@@@@@');
                                }
                                // AppRoutes.pushAndRemoveUntil(
                                //     context, RegMoreInfoScreen());
                              },
                            );
                          }),
                          SizedBox(height: 20),
                          divider(),
                          GestureDetector(
                            onTap: () {
                              AppRoutes.push(context, LoginPage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Already part of InstaJob",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                    style: ButtonStyle(overlayColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return MyColors.transparent;
                                      }
                                      return MyColors.blue;
                                    })),
                                    onPressed: () {
                                      // AppRoutes.push(context, LoginScreen());
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ))
                              ],
                            ),
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

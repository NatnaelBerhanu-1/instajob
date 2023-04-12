// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/globals.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: MyColors.white,
        body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: TextEditingController(),
                  validator: (val) {
                    return AppValidation.emailValidation(val.toString());
                  }),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print("object");
                    } else {
                      showToast("message");
                    }
                  },
                  child: Text("child"))
            ],
          ),
        ),
        /* Form(
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
                      child:
                          // BlocBuilder<GlobalCubit, InitialState>(
                          //     builder: (context, state) {
                          //   var validationBloc = context.read<GlobalCubit>();
                          //   return
                          Column(
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
                                AppValidation.emailValidation(val.toString()),
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
                                // validationBloc.visiblePass();
                              },
                              child: Icon(
                                // validationBloc.pass
                                //     ? Icons.visibility_off
                                //     :
                                Icons.visibility,
                              ),
                            ),
                            // obscureText: validationBloc.pass,
                            hint: "password",
                            maxLine: 1,
                            validator: (val) =>
                                AppValidation.passwordValidation(val.toString()),
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
                          // BlocConsumer<AuthCubit, AuthInitialState>(
                          //     listener: (context, state) {
                          //   if (state is ErrorState) {
                          //     showToast(state.error);
                          //   }
                          // }, builder: (context, state) {
                          //   var authCubit = context.read<AuthCubit>();
                          //   return
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  print("object");
                                } else {
                                  showToast("message");
                                }
                              },
                              child: Text("child")),
                          // CustomIconButton(
                          //   image: MyImages.arrowWhite,
                          //   title: "Sign In Now",
                          //   backgroundColor: MyColors.blue,
                          //   fontColor: MyColors.white,
                          //   // loading: state is AuthLoadingState ? true : false,
                          //   borderColor: MyColors.blue,
                          //   iconColor: MyColors.white,
                          //   onclick: () {
                          //     if (formKey.currentState!.validate()) {
                          //       print("33333333333333");
                          //       if (Global.type == "user") {
                          //         // authCubit.login(
                          //         //     email: email.text,
                          //         //     password: password.text,
                          //         //     isUser: true);
                          //       } else {
                          //         // authCubit.login(
                          //         //     email: email.text,
                          //         //     password: password.text);
                          //       }
                          //     } else {
                          //       print("1111111111111111");
                          //     }
                          //     // if (Global.type == "user") {
                          //     //   AppRoutes.pushAndRemoveUntil(
                          //     //       context, MemberShipScreen());
                          //     // } else {
                          //     //   AppRoutes.pushAndRemoveUntil(
                          //     //       context, BottomNavScreen());
                          //     // }
                          //   },
                          // ),
                          // ;
                          // }),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomSocialButton(image: MyImages.google),
                              CustomSocialButton(image: MyImages.twitter),
                              CustomSocialButton(image: MyImages.facebook),
                            ],
                          )
                        ],
                      ),
                      // ;
                      // }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),*/
      ),
    );
  }
}

/* Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(MyImages.bgCurve))),
      ),*/

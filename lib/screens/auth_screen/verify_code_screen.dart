// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/auth_bloc/social_auth/social_auth.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:pinput/pinput.dart';

import '../../utils/my_images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_cards/custom_common_card.dart';

class VerifyCodeScreen extends StatefulWidget {
  final bool isForgotPassword;
  const VerifyCodeScreen({super.key, this.isForgotPassword = false});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  TextEditingController code = TextEditingController();

  String verificationId = "";
  String otpCode = "";
  final submittedPinTheme = PinTheme(
    width: 58,
    height: 72,
    textStyle: TextStyle(
      fontSize: 22,
      backgroundColor: MyColors.white,
      color: MyColors.blue,
      fontWeight: FontWeight.w700,
      decorationColor: MyColors.blue,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: MyColors.blue),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "",
            )),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15, bottom: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Please enter your code found in your email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 40),
                Pinput(
                  controller: code,
                  autofocus: true,
                  length: 4,
                  defaultPinTheme: PinTheme(
                    width: 58,
                    height: 72,
                    textStyle: TextStyle(
                      fontSize: 22,
                      backgroundColor: MyColors.white,
                      color: MyColors.blue,
                      fontWeight: FontWeight.w700,
                      decorationColor: MyColors.blue,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: MyColors.lightGrey),
                    ),
                  ),
                  submittedPinTheme: submittedPinTheme,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsRetrieverApi,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onSubmitted: (pin) async {},
                ),
                SizedBox(height: 40),
                CommonText(
                  text: "I didn't receive the code",
                  fontWeight: FontWeight.w400,
                  fontColor: MyColors.grey,
                  fontSize: 13,
                ),
                SizedBox(height: 15),
                CommonText(
                  text: "Resend",
                  fontWeight: FontWeight.w500,
                  fontColor: MyColors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
                SizedBox(height: 70),
                // Spacer(),
                BlocBuilder<AuthCubit, AuthInitialState>(
                    builder: (context, state) {
                  return CustomIconButton(
                    image: MyImages.arrowWhite,
                    title: "Enter Code",
                    backgroundColor: MyColors.blue,
                    fontColor: MyColors.white,
                    borderColor: MyColors.blue,
                    iconColor: MyColors.white,
                    onclick: () {
                      onSubmit();
                    },
                  );
                }),
                // Spacer(),
                // Spacer(),
              ],
            ),
          ),
        ));
  }

  onSubmit() {
    var authData = context.read<AuthCubit>();
    if (widget.isForgotPassword) {
    } else {
      if (userType == "user") {
        if (authData.isSocialAuth) {
          authData.registerEmp(isUser: true);
        } else {
          SocialAuth.emailAndPass(context, isUser: true);
        }
      } else {
        if (authData.isSocialAuth) {
          authData.registerEmp();
        } else {
          SocialAuth.emailAndPass(context);
        }
      }
    }
  }
}

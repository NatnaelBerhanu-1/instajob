// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/globals.dart';
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
  int secondsRemaining = 1 * 60;
  bool enableResend = false;
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: secondsRemaining);

    String timerText =
        '0${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
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
                  "Please enter your code found in your ${widget.isForgotPassword ? "email" : "number"}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 40),
                Pinput(
                  controller: code,
                  autofocus: true,
                  length: widget.isForgotPassword ? 4 : 6,
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
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    secondsRemaining == 0 ? '' : timerText,
                  ),
                ),
                SizedBox(height: 15),
                BlocBuilder<AuthCubit, AuthInitialState>(
                    builder: (context, state) {
                  return GestureDetector(
                    onTap: enableResend
                        ? () async {
                            var authData = context.read<AuthCubit>();
                            if (widget.isForgotPassword) {
                              context
                                  .read<AuthCubit>()
                                  .sendCodeOnEmail(email: authData.email);
                            } else {
                              /// phone resend code
                              await authData.verifyPhone(context);
                            }
                            // AppRoutes.push(context, VerifyCodeScreen());
                          }
                        : null,
                    child: Center(
                      child: CommonText(
                        text: "Resend",
                        fontWeight: FontWeight.w500,
                        fontColor: MyColors.blue,
                        padding: true,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  );
                }),
                SizedBox(height: 70),
                // Spacer(),
                BlocBuilder<AuthCubit, AuthInitialState>(
                    builder: (context, state) {
                  return CustomIconButton(
                      image: MyImages.arrowWhite,
                      title: "Verify Code",
                      loading: state is AuthLoadingState ? true : false,
                      backgroundColor: MyColors.blue,
                      fontColor: MyColors.white,
                      borderColor: MyColors.blue,
                      iconColor: MyColors.white,
                      onclick: () {
                        if (code.text.isNotEmpty) {
                          if (widget.isForgotPassword
                              ? code.text.length == 4
                              : code.text.length == 6) {
                            if (widget.isForgotPassword) {
                              /// API NOT READY
                              context
                                  .read<AuthCubit>()
                                  .checkEmailVerificationCode(
                                      email: context.read<AuthCubit>().email,
                                      code: code.text);
                            } else {
                              context
                                  .read<AuthCubit>()
                                  .validateOTP(code.text, context);
                            }
                          } else {
                            showToast("Please enter correct code");
                          }
                        } else {
                          showToast("Please enter code");
                        }
                      });
                }),
                // Spacer(),
                // Spacer(),
              ],
            ),
          ),
        ));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/screens/insta_recruit/send_money/send_money_success_screen2.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:pinput/pinput.dart';

class VerifyMoneyTransferScreen extends StatefulWidget {
  const VerifyMoneyTransferScreen({super.key});

  @override
  State<VerifyMoneyTransferScreen> createState() => _VerifyMoneyTransferScreenState();
}

class _VerifyMoneyTransferScreenState extends State<VerifyMoneyTransferScreen> {
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
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6).copyWith(top: 28),
                child: const CustomAppBar(
                  title: "PIN",
                ),
              ),
            )),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15, bottom: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: Text.rich(
                    TextSpan(
                        text: "Enter the 4-digit code sent to you at ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: "+13454645634",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          )
                        ]),
                  ),
                ),
                const SizedBox(height: 40),
                Pinput(
                  // controller: code,
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
                const SizedBox(height: 40),
                CommonText(
                  text: "I didn't receive the code",
                  fontWeight: FontWeight.w400,
                  fontColor: MyColors.grey,
                  fontSize: 13,
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    secondsRemaining == 0 ? '' : timerText,
                  ),
                ),
                BlocBuilder<AuthCubit, AuthInitialState>(
                    builder: (context, state) {
                  return GestureDetector(
                    onTap: enableResend
                        ? () async {
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
                const SizedBox(height: 30),
                // Spacer(),
                BlocBuilder<AuthCubit, AuthInitialState>(
                    builder: (context, state) {
                  return CustomButton(
                      title: "Done",
                      fontColor: MyColors.white,
                      borderColor: MyColors.blue,
                      onTap: () {
                        // AppRoutes.push(context, const SendMoneySuccessScreen());
                        // AppRoutes.push(context, const SendMoneySuccessScreen());
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          // isDismissible: true,  
                          showDragHandle: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return Builder(
                              // initialChildSize: 0.75,
                              // maxChildSize: 1,
                              // minChildSize: 0.75,
                              // builder: (BuildContext context, ScrollController scrollController) {
                              builder: (BuildContext context) {
                                return const SendMoneySuccessScreen2();
                              }
                            );
                          },
                        );
                      },
                      );
                }),
              ],
            ),
          ),
        ));
  }
}
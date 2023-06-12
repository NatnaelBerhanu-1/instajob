// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_chip.dart';

import '../../utils/my_images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_cards/custom_common_card.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            title: "",
          )),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: "Forgot Password",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                SizedBox(height: 5),
                CommonText(
                  text: "Enter your Email Address to Retrieve Password",
                  fontWeight: FontWeight.w400,
                  fontColor: MyColors.grey,
                  fontSize: 13,
                ),
                SizedBox(height: 50),
                IconTextField(
                  controller: email,
                  prefixIcon: ImageButton(
                    image: MyImages.email,
                    padding: EdgeInsets.all(13),
                    height: 10,
                    width: 10,
                  ),
                  validator: (val) => emailValidation(val!),
                  onChanged: (val) {
                    if (!formKey.currentState!.validate()) {
                      emailValidation(val);
                    }
                  },
                  // suffixIcon: ImageButton(
                  //   image: MyImages.verified,
                  //   padding: EdgeInsets.all(13),
                  //   height: 10,
                  //   width: 10,
                  // ),
                  hint: "alexis@mygmail.com",
                ),
                SizedBox(height: 40),
                Center(
                  child: CommonText(
                    text: "I didn't receive the code",
                    fontWeight: FontWeight.w400,
                    fontColor: MyColors.grey,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 15),
                BlocConsumer<AuthCubit, AuthInitialState>(listener: (c, state) {
                  if (state is SuccessState) {
                    showToast("Send code on your email");
                  }
                }, builder: (context, state) {
                  return CustomGesture(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<AuthCubit>()
                            .sendCodeOnEmail(email: email.text);
                      }
                    },
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
                SizedBox(height: 55),
                BlocBuilder<AuthCubit, AuthInitialState>(
                    builder: (context, state) {
                  return CustomIconButton(
                    image: MyImages.arrowWhite,
                    title: "Submit Now",
                    loading: state is AuthLoadingState ? true : false,
                    backgroundColor: MyColors.blue,
                    fontColor: MyColors.white,
                    borderColor: MyColors.blue,
                    iconColor: MyColors.white,
                    onclick: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthCubit>().email = email.text;
                        context
                            .read<AuthCubit>()
                            .sendCodeOnEmail(email: email.text);
                        // AppRoutes.push(context, VerifyCodeScreen());
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

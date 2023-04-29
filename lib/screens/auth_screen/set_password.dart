// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/auth_screen/login_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';

import '../../utils/app_routes.dart';
import '../../utils/my_images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_cards/custom_common_card.dart';
import '../../widgets/custom_text_field.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({Key? key}) : super(key: key);

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController password = TextEditingController();
  final TextEditingController cPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
            child: BlocConsumer<ValidationCubit, InitialValidation>(
                listener: (context, state) {
              if (state is RequiredValidation) {
                showToast(state.require);
              }
              if (state is InvalidPasswordState) {
                showToast(state.pass);
              }
              if (state is ConfirmPasswordState) {
                showToast(state.pass);
              }
            }, builder: (context, state) {
              var validationBloc = context.read<ValidationCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: "Set your Password",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  SizedBox(height: 80),
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
                    hint: "**********",
                    maxLine: 1,
                    validator: (val) => passwordValidation(val!),
                    onChanged: (val) {
                      if (!formKey.currentState!.validate()) {
                        passwordValidation(val!);
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  IconTextField(
                    controller: cPassword,
                    prefixIcon: ImageButton(
                      image: MyImages.lock,
                      padding: EdgeInsets.all(13),
                      height: 10,
                      width: 10,
                    ),
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
                        confirmPassValidation(val!, password.text),
                    onChanged: (val) {
                      if (!formKey.currentState!.validate()) {
                        confirmPassValidation(val!, password.text);
                      }
                    },
                  ),
                  SizedBox(height: 70),
                  CustomIconButton(
                    image: MyImages.arrowWhite,
                    title: "Change Password",
                    backgroundColor: MyColors.blue,
                    fontColor: MyColors.white,
                    borderColor: MyColors.blue,
                    iconColor: MyColors.white,
                    onclick: () {
                      if (formKey.currentState!.validate()) {
                        AppRoutes.pushAndRemoveUntil(context, LoginScreen());
                      }
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_images.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_button/custom_img_button.dart';
import '../../widgets/custom_cards/assign_companies_tile.dart';
import '../../widgets/custom_cards/custom_common_card.dart';

class ChangeAccInfoScreen extends StatefulWidget {
  const ChangeAccInfoScreen({super.key});

  @override
  State<ChangeAccInfoScreen> createState() => _ChangeAccInfoScreenState();
}

class _ChangeAccInfoScreenState extends State<ChangeAccInfoScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();
  bool isValid = false;
  final formKey = GlobalKey<FormState>();
  InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.grey.withOpacity(.50), width: 1),
      borderRadius: BorderRadius.circular(10));
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 13.0, left: 5),
                            child: ImageButton(
                              onTap: () {
                                AppRoutes.pop(context);
                              },
                              image: MyImages.backArrow,
                              height: 40,
                              width: 40,
                              padding: EdgeInsets.zero,
                            ),
                          ),
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
                                    text: "Employ instantly",
                                    fontColor: MyColors.grey,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: BlocConsumer<ValidationCubit, InitialValidation>(
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
                      var validationBloc = context.read<ValidationCubit>();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Change Account Information",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Edit Information",
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
                            prefixIcon: ImageButton(
                              image: MyImages.userFilled,
                              padding: EdgeInsets.all(14),
                              height: 10,
                              width: 10,
                            ),
                            validator: (val) => validationBloc
                                .requiredValidation(val!, "Company name"),
                            // suffixIcon: ImageButton(image: MyImages.verified),
                            hint: "Company Name",
                          ),
                          SizedBox(height: 15),
                          IconTextField(
                            controller: email,
                            prefixIcon: ImageButton(
                              image: MyImages.email,
                              padding: EdgeInsets.all(14),
                              height: 10,
                              width: 10,
                            ),
                            validator: (val) =>
                                validationBloc.emailValidation(val!),
                            // suffixIcon: ImageButton(image: MyImages.verified),
                            hint: "alexies@mygmail.com",
                          ),
                          Global.userModel?.type != "user"
                              ? SizedBox()
                              : SizedBox(height: 15),
                          Global.userModel?.type != "user"
                              ? SizedBox()
                              : IconTextField(
                                  onPressed: () {},
                                  label: "Date of Birth",
                                  hint: "03/10/1998",
                                  readOnly: true,
                                  hintColor: MyColors.grey,
                                  prefixIcon: ImageButton(
                                    image: MyImages.cal,
                                    padding: EdgeInsets.all(12),
                                    height: 10,
                                    width: 10,
                                  ),
                                  suffixIcon: Icon(Icons.arrow_drop_down_sharp,
                                      color: MyColors.black, size: 25),
                                ),
                          Global.userModel?.type != "user"
                              ? SizedBox()
                              : SizedBox(height: 15),
                          Global.userModel?.type != "user"
                              ? SizedBox()
                              : IconTextField(
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
                                  validator: (val) =>
                                      validationBloc.passwordValidation(val!),
                                ),
                          SizedBox(height: 10),
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) async {
                              // print(number);
                            },
                            onInputValidated: (val) {
                              if (val == true) {
                                isValid = val;
                                setState(() {});
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                              print("VAL  ::: $val");
                            },
                            errorMessage: "",
                            autoValidateMode: AutovalidateMode.always,
                            selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                                leadingPadding: 10,
                                setSelectorButtonAsPrefixIcon: true,
                                showFlags: false),
                            ignoreBlank: false,
                            // keyboardType: TextInputType.number,
                            keyboardType: Platform.isIOS
                                ? TextInputType.numberWithOptions(
                                    signed: true, decimal: true)
                                : TextInputType.number,
                            formatInput: false,
                            initialValue: PhoneNumber(isoCode: "IN"),
                            textFieldController: phone,
                            inputDecoration: InputDecoration(
                              // prefixIcon:
                              // ImageButton(
                              //   image: MyImages.phone,
                              //   padding: EdgeInsets.zero,
                              // ),
                              isDense: true,
                              fillColor: MyColors.white,
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              hintText: "",
                              hintStyle: TextStyle(fontSize: 13),
                              border: border,
                              enabledBorder: border,
                              errorBorder: border,
                              focusedErrorBorder: border,
                              focusedBorder: border,
                            ),
                            cursorColor: MyColors.black,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Upload Photo",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: MyColors.grey),
                          ),
                          SizedBox(height: 10),
                          uploadPhotoCard(context),
                          SizedBox(height: 50),
                          CustomIconButton(
                            image: MyImages.arrowWhite,
                            title: "Change Information",
                            backgroundColor: MyColors.blue,
                            fontColor: MyColors.white,
                            borderColor: MyColors.blue,
                            iconColor: MyColors.white,
                            onclick: () {
                              if (formKey.currentState!.validate()) {
                                if (phone.text.isEmpty) {
                                  showToast("Phone number is required");
                                } else {
                                  if (isValid) {
                                  } else {
                                    showToast("Please enter valid number");
                                  }
                                }
                              } else {
                                print("333333333333333");
                              }
                            },
                          ),
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

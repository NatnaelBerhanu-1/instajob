// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/widgets/custom_button/custom_all_small_button.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_images.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_button/custom_img_button.dart';
import '../../widgets/custom_cards/custom_common_card.dart';
import '../../widgets/custom_divider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
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
                              CustomCommonText(
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
                  child: Column(
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
                      CustomTextField(
                        prefixIcon: ImageButton(image: MyImages.userFilled),
                        suffixIcon: ImageButton(image: MyImages.verified),
                        hint: "alexies@mygmail.com",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        prefixIcon: ImageButton(image: MyImages.email),
                        suffixIcon: ImageButton(image: MyImages.verified),
                        hint: "alexies@mygmail.com",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        prefixIcon: ImageButton(image: MyImages.lock),
                        suffixIcon: ImageButton(image: MyImages.visible),
                        hint: "password",
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        prefixIcon: ImageButton(image: MyImages.lock),
                        suffixIcon: ImageButton(image: MyImages.visible),
                        hint: "confirm password",
                      ),
                      SizedBox(height: 20),
                      CustomCheckbox(
                        onchanged: (val) {},
                        value: true,
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
                      /*Row(
                        children: [
                          Expanded(
                              flex: 0,
                              child: CustomCheckbox(
                                onchanged: (val) {},
                              )),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: "I accept all the ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.grey,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
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
                        ],
                      ),*/
                      SizedBox(height: 40),
                      CustomIconButton(
                        image: MyImages.arrowWhite,
                        title: "Register",
                        backgroundColor: MyColors.blue,
                        fontColor: MyColors.white,
                        borderColor: MyColors.blue,
                        iconColor: MyColors.white,
                      ),
                      SizedBox(height: 20),
                      divider(),
                      Row(
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
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return MyColors.transparent;
                                }
                                return MyColors.blue;
                              })),
                              onPressed: () {},
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

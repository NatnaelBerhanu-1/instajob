// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';

import '../../utils/my_images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_cards/custom_common_card.dart';
import '../../widgets/custom_text_field.dart';

class SetPassword extends StatelessWidget {
  const SetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            title: "",
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "Set your Password",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              SizedBox(height: 80),
              IconTextField(
                prefixIcon: ImageButton(image: MyImages.lock),
                suffixIcon: ImageButton(image: MyImages.visible),
                hint: "**********",
              ),
              SizedBox(height: 30),
              IconTextField(
                prefixIcon: ImageButton(image: MyImages.lock),
                suffixIcon: ImageButton(image: MyImages.visible),
                hint: "confirm password",
              ),
              SizedBox(height: 70),
              CustomIconButton(
                image: MyImages.arrowWhite,
                title: "Change Password",
                backgroundColor: MyColors.blue,
                fontColor: MyColors.white,
                borderColor: MyColors.blue,
                iconColor: MyColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

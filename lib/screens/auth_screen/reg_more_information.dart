// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:insta_job/screens/auth_screen/verify_code_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';

import '../../utils/app_routes.dart';
import '../../utils/my_images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_text_field.dart';

class RegMoreInfoScreen extends StatelessWidget {
  const RegMoreInfoScreen({Key? key}) : super(key: key);

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
              Text(
                "Please Enter More Information",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 40),
              IconTextField(
                readOnly: true,
                prefixIcon: ImageButton(image: MyImages.cal),
                suffixIcon: Icon(Icons.arrow_drop_down_sharp,
                    color: MyColors.black, size: 25),
                hint: "9/09/1987",
              ),
              SizedBox(height: 30),
              CustomPhonePickerTextField(label: "Phone Number"),
              SizedBox(height: 10),
              Text(
                "Upload Photo",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: MyColors.grey),
              ),
              SizedBox(height: 10),
              uploadPhotoCard(context),
              SizedBox(height: 30),
              CustomButton(
                title: "Upload your Existing CV",
                bgColor: MyColors.white,
                borderColor: MyColors.blue,
                fontColor: MyColors.blue,
              ),
              SizedBox(height: 50),
              CustomIconButton(
                image: MyImages.arrowWhite,
                title: "Continue",
                backgroundColor: MyColors.blue,
                fontColor: MyColors.white,
                borderColor: MyColors.blue,
                iconColor: MyColors.white,
                onclick: () {
                  AppRoutes.push(context, VerifyCodeScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

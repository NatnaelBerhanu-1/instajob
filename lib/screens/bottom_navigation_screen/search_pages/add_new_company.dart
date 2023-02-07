// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../utils/my_images.dart';
import '../../../widgets/custom_app_bar.dart';

class AddNewCompany extends StatelessWidget {
  const AddNewCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppBar(
          leadingImage: MyImages.backArrowBorder,
          title: "",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Column(
            children: [
              Center(child: Image.asset(MyImages.resume)),
              SizedBox(height: 30),
              CommonText(
                text: "Add Clients Information",
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 30),
              IconTextField(
                prefixIcon: ImageButton(image: MyImages.userFilled),
                suffixIcon: ImageButton(image: MyImages.verified),
                hint: "Company Name",
              ),
              SizedBox(height: 30),
              uploadPhotoCard(),
              SizedBox(height: 30),
              CustomButton(title: "Submit")
            ],
          ),
        ),
      ),
    );
  }
}

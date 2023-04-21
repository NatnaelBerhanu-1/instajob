// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/setting_pages/save_card_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button/custom_btn.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Add Cards",
              centerTitle: false,
              leadingImage: MyImages.arrowBlueLeft,
              height: 17,
              width: 17,
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Material(
                  elevation: 7,
                  shadowColor: MyColors.grey.withOpacity(.14),
                  borderRadius: BorderRadius.circular(12),
                  child: IconTextField(
                    prefixIcon: ImageButton(
                      image: MyImages.visaCardBlue,
                      padding: EdgeInsets.all(14),
                      height: 10,
                      width: 10,
                    ),
                    hint: "Card Number",
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        elevation: 7,
                        shadowColor: MyColors.grey.withOpacity(.14),
                        borderRadius: BorderRadius.circular(12),
                        child: IconTextField(
                          prefixIcon: ImageButton(
                            image: MyImages.cal,
                            padding: EdgeInsets.all(14),
                            height: 10,
                            width: 10,
                          ),
                          hint: "05/21",
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Material(
                        elevation: 7,
                        shadowColor: MyColors.grey.withOpacity(.14),
                        borderRadius: BorderRadius.circular(12),
                        child: CustomTextField(
                          hint: "CVV",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Material(
                  elevation: 7,
                  shadowColor: MyColors.grey.withOpacity(.14),
                  borderRadius: BorderRadius.circular(12),
                  child: IconTextField(
                    prefixIcon: ImageButton(
                      image: MyImages.user,
                      padding: EdgeInsets.all(14),
                      height: 10,
                      width: 10,
                    ),
                    hint: "Card Holder Name",
                  ),
                ),
                SizedBox(height: 60),
                CustomButton(
                  title: "Add Card",
                  onTap: () {
                    AppRoutes.push(
                        context, SaveCardScreen(isChoosePayment: true));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

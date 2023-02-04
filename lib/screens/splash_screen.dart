// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/user_tile/custom_acc_details.dart';
import 'package:insta_job/widgets/custom_cards/custom_user_type_card.dart';

import '../widgets/custom_button/custom_img_button.dart';
import '../widgets/custom_cards/custom_common_card.dart';
import '../widgets/custom_cards/setting_tile.dart';
import '../widgets/user_tile/custom_job_boards_card.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                child: CustomCommonText(
                  text: "Welcome",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // SizedBox(height: 20),
              // ImageButton(
              //   image: MyImages.logo,
              //   padding: EdgeInsets.zero,
              //   height: MediaQuery.of(context).size.height * 0.17,
              //   width: MediaQuery.of(context).size.width * 0.4,
              // ),
              CustomAccDetails(
                img: MyImages.rate,
                title: "Feedbacks",
              ),
              SizedBox(height: 20),
              CustomJobBoardsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../../utils/my_colors.dart';

class JobPositionScreen extends StatelessWidget {
  const JobPositionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            right: 0,
            top: 0,
            left: 0,
            child: Image.asset(MyImages.jobUser, fit: BoxFit.cover)),
        Positioned(
          top: 30,
          child: ImageButton(
            image: MyImages.backArrow,
            height: 40,
            width: 40,
          ),
        ),
        Positioned(
            left: 0,
            top: MediaQuery.of(context).size.height * 0.36,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: "Job Position",
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImageButton(
                              image: MyImages.bag, padding: EdgeInsets.zero),
                          SizedBox(width: 5),
                          CommonText(
                            text: "Job Position",
                            fontColor: MyColors.blue,
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    ));
  }
}

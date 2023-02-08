// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../utils/my_colors.dart';
import '../custom_button/custom_img_button.dart';

class JobOpeningTile extends StatelessWidget {
  final bool? isFav;
  const JobOpeningTile({Key? key, this.isFav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyColors.grey.withOpacity(.30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.10),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(2, 3))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
          child: Row(
            children: [
              ImageButton(
                image: MyImages.suitcase,
                height: 40,
                width: 40,
                padding: EdgeInsets.zero,
              ),
              SizedBox(width: 10),
              CommonText(
                text: "Job Opening",
                fontSize: 14,
                fontColor: MyColors.black,
                overflow: TextOverflow.clip,
                fontWeight: FontWeight.w400,
              ),
              Spacer(),
              isFav == true
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ImageButton(
                        image: MyImages.fav,
                        color: MyColors.grey,
                        padding: EdgeInsets.zero,
                        height: 20,
                        width: 20,
                      ),
                    )
                  : CustomCommonCard(
                      bgColor: MyColors.lightBlue,
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            ImageButton(
                              image: MyImages.safety,
                              padding: EdgeInsets.zero,
                              height: 14,
                              width: 14,
                            ),
                            SizedBox(width: 5),
                            CommonText(
                              text: "applied",
                              fontSize: 12,
                              fontColor: MyColors.white,
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}

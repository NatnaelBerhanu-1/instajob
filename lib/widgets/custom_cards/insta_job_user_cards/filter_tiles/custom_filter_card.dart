// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';

import '../../../../utils/my_images.dart';

class CustomFilterCard extends StatelessWidget {
  final String? title;
  final String? heading;
  final List<Widget> children;
  const CustomFilterCard(
      {Key? key, this.title, required this.children, this.heading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: "$heading",
        ),
        SizedBox(height: 9),
        CustomCommonCard(
          borderColor: MyColors.grey.withOpacity(.30),
          borderRadius: BorderRadius.circular(7),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      text: "$title",
                      fontSize: 12,
                      fontColor: MyColors.blue,
                    ),
                    ImageButton(
                      image: MyImages.verified,
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),
                SizedBox(height: 10),
                divider(color: MyColors.grey.withOpacity(.40)),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildTitleTile({String? label, bool hideDivider = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText(
        padding: true,
        text: label,
        fontSize: 14,
        fontColor: MyColors.grey,
      ),
      SizedBox(height: 5),
      hideDivider ? SizedBox() : divider(color: MyColors.grey.withOpacity(.40)),
    ],
  );
}

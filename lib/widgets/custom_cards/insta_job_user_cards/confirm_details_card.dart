// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

class ConfirmDetailTile extends StatelessWidget {
  // final String? title;
  final String? heading;
  final Widget child;
  const ConfirmDetailTile({
    Key? key,
    // this.title,
    this.heading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: "$heading",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 9),
        CustomCommonCard(
          borderColor: MyColors.grey.withOpacity(.30),
          borderRadius: BorderRadius.circular(7),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: child),
                // Spacer(),
                Expanded(
                  flex: 0,
                  child: CommonText(
                    text: "Confirm",
                    fontColor: Colors.orange,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 0,
                  child: CommonText(
                    text: "Edit",
                    fontColor: MyColors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

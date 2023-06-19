// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';

class OccupationDetailTile extends StatelessWidget {
  final String? heading;
  final Widget child;
  const OccupationDetailTile({Key? key, this.heading, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: CustomCommonCard(
        borderColor: MyColors.grey.withOpacity(.30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CommonText(
                        text: "$heading",
                        fontWeight: FontWeight.w500,
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: MyColors.grey,
                      )
                    ],
                  ),
                ],
              ),
            ),
            divider(),
            child
          ],
        ),
      ),
    );
  }
}

class DropTile extends StatelessWidget {
  const DropTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          CommonText(
            text: "Data vmdflksfdsgioun nfokdslmlk",
            fontSize: 14,
            fontColor: MyColors.blue,
          ),
          SizedBox(height: 5),
          CommonText(
            text: "Data vmdflksfdsgioun nfokdslmlk",
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}

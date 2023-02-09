// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/my_colors.dart';
import '../utils/my_images.dart';
import 'custom_button/custom_img_button.dart';
import 'custom_cards/custom_common_card.dart';

class DeniedCandidateTile extends StatelessWidget {
  const DeniedCandidateTile({Key? key}) : super(key: key);

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "Candidate",
                            fontSize: 14,
                            fontColor: MyColors.black,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 5),
                          CommonText(
                            text: "2714 wasterrn ave.",
                            fontSize: 12,
                            fontColor: MyColors.black,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CustomCommonCard(
                        bgColor: MyColors.lightBlue.withOpacity(.20),
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CommonText(
                            text: "4 year degree",
                            fontSize: 12,
                            fontColor: MyColors.blue,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      CustomCommonCard(
                        bgColor: Colors.purpleAccent.withOpacity(.30),
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CommonText(
                            text: "6+ year",
                            fontSize: 12,
                            fontColor: Colors.purpleAccent,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Spacer(),
              ImageButton(
                image: MyImages.rightArrow,
                padding: EdgeInsets.zero,
                height: 14,
                width: 14,
              ),
            ],
          ),
        ));
  }
}

Widget buildDeniedCandidateTile() {
  return ListView.builder(
      itemCount: 7,
      itemBuilder: (c, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: DeniedCandidateTile(),
        );
      });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';

import '../../utils/my_images.dart';
import '../custom_cards/custom_common_card.dart';

class CustomJobBoardsCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? image;
  final Color? color;
  final Color? desc;
  const CustomJobBoardsCard(
      {Key? key, this.image, this.color, this.desc, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image.toString()),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 0,
                  child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(MyImages.verified),
                      ))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      CommonText(
                        text: "Enterprise",
                        fontColor: color ?? MyColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                      SizedBox(height: 10),
                      CustomCommonCard(
                        borderRadius: BorderRadius.circular(5),
                        bgColor: MyColors.white.withOpacity(.20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CommonText(
                            fontSize: 14,
                            text: "Contact Us",
                            fontColor: color ?? MyColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      CommonText(
                        fontSize: 12,
                        text: "Unlimited job parts",
                        fontColor: desc ?? MyColors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(MyImages.rateYellow)
            ],
          ),
        ),
      ),
    );
  }
}

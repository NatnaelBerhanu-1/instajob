// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

class CustomSearchChip extends StatelessWidget {
  final int? index;
  final int? selectedIndex;
  final String? image;
  final String? title;
  final VoidCallback? onTap;

  const CustomSearchChip(
      {Key? key,
      this.index,
      this.selectedIndex,
      this.image,
      this.onTap,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == selectedIndex ? MyColors.blue : MyColors.white,
            // image: DecorationImage(image: AssetImage(MyImages.suitcase)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.10),
                spreadRadius: 5,
                blurRadius: 7,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(image ?? MyImages.businessAndTrade),
                  // fit: BoxFit.contain,
                  opacity: index == selectedIndex ? 0.5 : 10,
                  alignment: Alignment.topLeft),
            ),
            child: Column(
              children: [
                // Image.asset(
                //   MyImages.suitcase,
                //   // height: 30,
                //   // width: 30,
                //   // color: MyColors.lightBlue,
                // ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageButton(
                      image: MyImages.searchGrey,
                      color: index == selectedIndex
                          ? MyColors.white
                          : MyColors.blue,
                    ),
                    CommonText(
                      text: title,
                      fontSize: 13,
                      fontColor: index == selectedIndex
                          ? MyColors.white
                          : MyColors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

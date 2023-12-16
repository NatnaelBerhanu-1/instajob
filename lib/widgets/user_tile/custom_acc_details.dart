import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';

import '../custom_button/custom_img_button.dart';
import '../custom_cards/custom_common_card.dart';

class CustomAccDetails extends StatelessWidget {
  final String? img;
  final String? title;
  final double? height;
  final double? width;
  final int? index;
  final int? selectedIndex;
  final bool isLock;
  final VoidCallback? onTap;
  const CustomAccDetails(
      {Key? key,
      this.img,
      this.title,
      this.height,
      this.width,
      this.index,
      this.selectedIndex,
      this.onTap, this.isLock=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        // width: width,
        decoration: BoxDecoration(
            color: index == selectedIndex ? MyColors.blue : MyColors.white,
            boxShadow: [
              BoxShadow(
                color: MyColors.grey.withOpacity(0.12),
                spreadRadius: 5,
                blurRadius: 10,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
             isLock?  Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                    child: Icon(Icons.lock,color: MyColors.blue,size: 20)),
              ):const SizedBox(height: 35),
              // const SizedBox(height: 10),
              ImageButton(
                image: img,
                color: index == selectedIndex ? MyColors.white : MyColors.blue,
              ),
              CommonText(
                text: title,
                fontColor:
                    index == selectedIndex ? MyColors.white : MyColors.userFont,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../custom_button/custom_img_button.dart';

class AssignCompaniesTile extends StatelessWidget {
  final String? title;
  final String? leadingImage;
  const AssignCompaniesTile({Key? key, this.title, this.leadingImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.grey),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.10),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(2, 3))
          ]),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: MyColors.grey),
            borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(6),
        tileColor: MyColors.white,
        leading: ImageButton(image: leadingImage),
        title: Text(
          "$title",
          style: TextStyle(
            fontSize: 16,
            color: MyColors.black,
            overflow: TextOverflow.clip,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: ImageButton(
          padding: EdgeInsets.only(right: 0),
          image: MyImages.rightArrow,
          color: MyColors.blue,
          height: 13,
        ),
      ),
    );
  }
}

Widget uploadPhotoCard() {
  return CustomCommonCard(
    bgColor: MyColors.blue.withOpacity(.10),
    borderRadius: BorderRadius.circular(10),
    borderColor: MyColors.lightBlue,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageButton(
            image: MyImages.upload,
          ),
          CustomCommonText(
            text: "Upload Photo",
            fontColor: MyColors.blue,
          )
        ],
      ),
    ),
  );
}

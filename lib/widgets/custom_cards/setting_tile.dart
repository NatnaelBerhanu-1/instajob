// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_images.dart';

import '../../utils/my_colors.dart';
import '../custom_button/custom_img_button.dart';

class SettingTile extends StatelessWidget {
  final String? title;
  final String? trailingImage;
  final String? leadingImage;
  final VoidCallback? onTap;

  const SettingTile(
      {super.key,
      this.title,
      this.trailingImage,
      this.leadingImage,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
          leading: ImageButton(
            image: leadingImage,
            // padding: EdgeInsets.all(14),
            height: 28,
            width: 28,
          ),
          title: Text(
            "$title",
            style: TextStyle(
              fontSize: 15,
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
        Divider(
          color: MyColors.grey,
        ),
      ],
    );
  }
}

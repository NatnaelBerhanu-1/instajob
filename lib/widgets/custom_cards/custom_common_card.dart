// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';

import '../../utils/my_colors.dart';

class CustomCommonCard extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final Color? bgColor;
  final BoxShadow? boxShadow;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final VoidCallback? onTap;
  const CustomCommonCard(
      {Key? key,
      this.child,
      this.bgColor,
      this.boxShadow,
      this.onTap,
      this.borderRadius,
      this.borderColor,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            color: bgColor ?? MyColors.white,
            border: Border.all(
                color: borderColor ?? MyColors.transparent, width: 1.5),
          ),
          child: child,
        ));
  }
}

class CommonText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final bool? padding;
  const CommonText(
      {super.key,
      this.text,
      this.fontSize,
      this.fontWeight,
      this.fontColor,
      this.decoration,
      this.overflow,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == true ? const EdgeInsets.all(5.0) : EdgeInsets.zero,
      child: Text(
        "$text",
        style: TextStyle(
          fontSize: fontSize ?? 15,
          color: fontColor ?? MyColors.black,
          decoration: decoration ?? TextDecoration.none,
          fontWeight: fontWeight ?? FontWeight.w400,
          overflow: overflow,
        ),
      ),
    );
  }
}

jobTypeTile(
    {String? title,
    String? value,
    String? selectedValue,
    VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(4),
      color: MyColors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            padding: true,
            text: "$title",
            fontSize: 13,
            fontColor: value == selectedValue ? MyColors.blue : MyColors.grey,
          ),
          value == selectedValue
              ? ImageButton(
                  image: MyImages.verified,
                  padding: EdgeInsets.zero,
                )
              : SizedBox()
        ],
      ),
    ),
  );
}

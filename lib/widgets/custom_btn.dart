import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final double? height;
  final Color? bgColor;
  final Color? borderColor;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? width;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  const CustomButton(
      {Key? key,
      this.title,
      this.height,
      this.width,
      this.onTap,
      this.borderRadius,
      this.fontWeight,
      this.fontSize,
      this.bgColor,
      this.fontColor,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.052,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: bgColor ?? MyColors.white,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            border:
                Border.all(color: borderColor ?? MyColors.white, width: 1.2)),
        child: Center(
          child: Text(
            "$title",
            style: TextStyle(
              fontSize: fontSize ?? 15,
              fontWeight: fontWeight ?? FontWeight.w500,
              color: fontColor ?? MyColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../utils/my_colors.dart';
import 'custom_img_button.dart';

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
            border: Border.all(
                color: borderColor ?? MyColors.transparent, width: 1.2)),
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

class CustomIconButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onclick;
  final String? image;
  final double? height;
  final double? width;
  final double? fontSize;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? fontColor;
  final Color? borderColor;
  final Color? iconColor;

  const CustomIconButton(
      {Key? key,
      this.title,
      this.onclick,
      this.image,
      this.backgroundColor,
      this.height,
      this.width,
      this.borderRadius,
      this.fontSize,
      this.fontColor,
      this.borderColor,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
          height: height ?? MediaQuery.of(context).size.height * 0.075,
          width: width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: backgroundColor ?? MyColors.blue,
              borderRadius: borderRadius ?? BorderRadius.circular(10),
              border: Border.all(color: borderColor ?? Colors.transparent)),
          child: ListTile(
            leading: SizedBox(),
            title: Text(
              "$title",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 16,
                color: fontColor ?? MyColors.white,
                overflow: TextOverflow.clip,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: ImageButton(
              padding: EdgeInsets.only(right: 10),
              image: image,
              color: iconColor ?? MyColors.white,
              // height: 12,
            ),
          )
          /* Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer(),
            Expanded(
              flex: 6,
              child: Text(
                "$title",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize ?? 16,
                  color: fontColor ?? MyColors.white,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // SizedBox(width: 40),
            // Spacer(),
            image == null
                ? const SizedBox()
                : Expanded(
                    flex: 1,
                    child: ImageButton(
                      padding: EdgeInsets.only(right: 10),
                      image: image,
                      color: MyColors.white,
                      height: 12,
                    ),
                  ),
          ],
        ),*/
          ),
    );
  }
}

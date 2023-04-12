// ignore_for_file: prefer_const_constructors

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../utils/my_colors.dart';
import '../custom_cards/custom_common_card.dart';
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
        height: height ?? MediaQuery.of(context).size.height * 0.075,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: bgColor ?? MyColors.blue,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            border: Border.all(
                color: borderColor ?? MyColors.transparent, width: 1.2)),
        child: Center(
          child: Text(
            "$title",
            style: TextStyle(
              fontSize: fontSize ?? 16,
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
  final bool loading;
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
      this.iconColor,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onclick,
      child: Container(
          height: height ?? MediaQuery.of(context).size.height * 0.075,
          width: width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: backgroundColor ?? MyColors.blue,
              borderRadius: borderRadius ?? BorderRadius.circular(10),
              border: Border.all(color: borderColor ?? Colors.transparent)),
          child: ListTile(
            leading: SizedBox(),
            title: loading
                ? Center(
                    heightFactor: 0,
                    widthFactor: 0,
                    child: CircularProgressIndicator(
                        color: MyColors.white, strokeWidth: 2),
                  )
                : Text(
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
          )),
    );
  }
}

class DottedButton extends StatelessWidget {
  final VoidCallback? onTap;
  const DottedButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(5),
        strokeWidth: 1,
        strokeCap: StrokeCap.round,
        dashPattern: [8, 4],
        color: MyColors.blue.withOpacity(0.70),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: CommonText(
                text: "Add New Card",
                fontColor: MyColors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

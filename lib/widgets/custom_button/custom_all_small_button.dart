// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../utils/my_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final Function(bool?)? onchanged;
  final Widget? title;
  final MaterialStateProperty<Color?>? color;
  final bool? value;
  const CustomCheckbox(
      {Key? key, this.onchanged, this.value, this.color, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 0,
          child: Checkbox(

            visualDensity: VisualDensity.comfortable,
            // fillColor: color ?? MaterialStateProperty.all(MyColors.blue),
            activeColor: MyColors.blue,
            onChanged: onchanged,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            value: value,
            // activeColor: MyColors.green,
            // checkColor: MyColors.white,
            side: BorderSide(color: MyColors.grey, width: 1.2),
          ),
        ),
        Expanded(child: title!),
      ],
    );
  }
}

class CustomSocialButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? image;
  const CustomSocialButton({Key? key, this.onTap, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCommonCard(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      bgColor: MyColors.white,
      borderColor: MyColors.borderClr,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ImageButton(
          image: image,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}

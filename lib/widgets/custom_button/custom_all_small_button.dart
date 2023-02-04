// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_images.dart';

class CustomCheckbox extends StatelessWidget {
  final Function(bool?)? onchanged;
  final String? title;
  final MaterialStateProperty<Color?>? color;
  final bool? value;
  const CustomCheckbox(
      {Key? key, this.onchanged, this.value, this.color, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          visualDensity: VisualDensity.comfortable,
          fillColor: color ?? MaterialStateProperty.all(MyColors.blue),
          onChanged: onchanged,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          value: value,
          // activeColor: MyColors.green,
          // checkColor: MyColors.white,
          side: BorderSide(color: MyColors.blue, width: 1.2),
        ),
        SizedBox(width: 5),
        Text(
          "$title",
          style: TextStyle(
              fontSize: 16, color: MyColors.black, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class CustomSocialButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomSocialButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCommonCard(
      onTap: onTap,
      borderColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ImageButton(
          image: MyImages.google,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}

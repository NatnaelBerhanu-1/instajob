import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

class CustomDivider extends StatelessWidget {
  final String? title;
  final Color? color;
  const CustomDivider({Key? key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 0,
          child: CommonText(
            text: title ?? "Sign Up with",
            fontColor: color ?? MyColors.grey,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Divider(color: MyColors.grey)),
      ],
    );
  }
}

Divider divider({Color? color}) {
  return Divider(color: color ?? MyColors.grey);
}

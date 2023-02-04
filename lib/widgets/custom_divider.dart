import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 0,
          child: CustomCommonText(
            text: "Sign Up with",
            fontColor: MyColors.grey,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Divider(color: MyColors.black)),
      ],
    );
  }
}

Divider divider() {
  return Divider(color: MyColors.black);
}

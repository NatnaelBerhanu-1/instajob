import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../utils/my_colors.dart';
import '../widgets/custom_cards/custom_common_card.dart';

class ChoosePaymentOptionPage extends StatelessWidget {
  const ChoosePaymentOptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DottedBorder(
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
              child: CustomCommonText(
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

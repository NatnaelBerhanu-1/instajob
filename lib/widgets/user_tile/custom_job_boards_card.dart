import 'package:flutter/material.dart';
import 'package:insta_job/screens/splash_screen.dart';
import 'package:insta_job/utils/my_colors.dart';

import '../../utils/my_images.dart';
import '../custom_cards/custom_common_card.dart';

class CustomJobBoardsCard extends StatelessWidget {
  const CustomJobBoardsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: MyColors.grey,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(MyImages.enterprise),
        ),
      ),
      child: CustomCommonText(
        text: "Enterprise",
        fontColor: MyColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

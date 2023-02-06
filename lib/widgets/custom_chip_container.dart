import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: MyColors.grey,
      ),
      child: Row(
        children: [],
      ),
    );
  }
}

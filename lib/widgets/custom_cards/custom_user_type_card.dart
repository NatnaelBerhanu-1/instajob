import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_colors.dart';

import '../../utils/my_images.dart';
import '../custom_button/custom_img_button.dart';
import 'custom_common_card.dart';

class UserTypeCard extends StatelessWidget {
  final String? image;
  final String? title;
  final int? index;
  final int? selectedIndex;
  final VoidCallback? onTap;
  const UserTypeCard(
      {Key? key,
      this.image,
      this.title,
      this.index,
      this.selectedIndex,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 140,
            color: MyColors.transparent,
          ),
          Positioned(
            top: 20,
            left: 30,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:
                      index == selectedIndex ? MyColors.blue : MyColors.white,
                  boxShadow: [blueBoxShadow],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 45, right: 25, left: 25, bottom: 10),
                  child: Column(
                    children: [
                      CommonText(
                        text: title,
                        fontColor: index == selectedIndex
                            ? MyColors.white
                            : MyColors.blue,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 5),
                      ImageButton(
                        image: index == selectedIndex
                            ? MyImages.arrow_white_circle
                            : MyImages.nextArrow,
                        padding: EdgeInsets.zero,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: FloatingActionButton(
              heroTag: "$title",
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.white,
                  // boxShadow: [boxShadow],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ImageButton(
                    image: image,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          )
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: MyColors.white,
          //         boxShadow: [boxShadow],
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.all(15.0),
          //         child: ImageButton(
          //           image: image,
          //           padding: EdgeInsets.zero,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

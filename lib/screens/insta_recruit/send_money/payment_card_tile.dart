// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';


class PaymentCardTile extends StatelessWidget {
  final String? image;
  final Color? borderColor;
  final int? index;
  final int? selectedIndex;
  final void Function()? onClick;
  final bool isSelectMode;
  const PaymentCardTile(
      {Key? key,
      this.image,
      this.borderColor,
      this.index,
      this.selectedIndex,
      this.onClick, 
      this.isSelectMode = true,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onClick,
      contentPadding: EdgeInsets.all(0),
      title: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: MyColors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.10),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(2, 3))
                ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, top: 11, left: 15, bottom: 15),
              child: Row(
                children: [
                  Column(
                    children: [
                      ImageButton(
                        image: "$image",
                        padding: EdgeInsets.zero,
                        height: 25,
                        width: 25,
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nicholas M.",
                        style: TextStyle(
                          fontSize: 16,
                          color: MyColors.black,
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        "***2243",
                        style: TextStyle(
                          fontSize: 14,
                          color: MyColors.lightBlack.withOpacity(0.7),
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // index == selectedIndex
                  //     ? ImageButton(
                  //         padding: EdgeInsets.all(1),
                  //         image: MyImages.verified,
                  //         height: 20,
                  //         width: 20,
                  //       )
                  //     : Container(
                  //         height: 20,
                  //         width: 20,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: MyColors.white,
                  //             border: Border.all(color: MyColors.grey)),
                  //       )
                  if (isSelectMode)
                    Radio(
                    value: index,
                    groupValue: selectedIndex,
                    activeColor: MyColors.blue,
                    onChanged: (value) {
                      if (onClick != null) {
                        onClick!();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

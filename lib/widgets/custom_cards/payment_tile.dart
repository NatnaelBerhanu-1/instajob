// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_images.dart';
import '../custom_button/custom_img_button.dart';

class PaymentTile extends StatelessWidget {
  final String? userName;
  final String? image;
  final Color? borderColor;
  final int? index;
  final int? selectedIndex;
  final void Function()? onClick;
  const PaymentTile(
      {Key? key,
      this.userName,
      this.image,
      this.borderColor,
      this.index,
      this.selectedIndex,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
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
          padding:
              const EdgeInsets.only(right: 20.0, top: 11, left: 15, bottom: 15),
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
                    "$userName",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: MyColors.black),
                  ),
                ],
              ),
              Spacer(),
              index == selectedIndex
                  ? ImageButton(
                      padding: EdgeInsets.all(1),
                      image: MyImages.verified,
                      height: 20,
                      width: 20,
                    )
                  : Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.white,
                          border: Border.all(color: MyColors.grey)),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

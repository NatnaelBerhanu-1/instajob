// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/model/payment_user.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';


class PaymentUserTile extends StatelessWidget {
  final String? image;
  final Color? borderColor;
  final int? index;
  final int? selectedIndex;
  final void Function()? onClick;
  final bool isSelectMode;
  final PaymentUser user;
  const PaymentUserTile(
      {Key? key,
      this.image,
      this.borderColor,
      this.index,
      this.selectedIndex,
      this.onClick, 
      this.isSelectMode = true,
      required this.user,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isSelectMode && selectedIndex == index ? Border.all(
          color: Colors.blue, // Border color
          width: 2.0, // Border width
        ) : null,
        borderRadius: BorderRadius.circular(10.0), // Optional: to make the border rounded
      ),
      child: ListTile(
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
                  ],
                ),
              child: Padding(
                padding: const EdgeInsets.only(
                    // right: 20.0, top: 4, left: 15, bottom: 8),
                    right: 12.0, top: 6, left: 15, bottom: 6),
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
                          // "Nicholas M.",
                          // user.name ?? "",
                          user.name ?? "Unknown",
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColors.black,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
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
      ),
    );
  }
}

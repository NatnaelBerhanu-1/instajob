// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';

import '../../utils/my_images.dart';
import '../custom_cards/custom_common_card.dart';

class CustomJobBoardsCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? image;
  final String? price;
  final String? desc;
  final String? heading;
  final Color? color;
  final Color? descColor;
  final Color? priceColor;
  final int? index;
  final int? sIndex;
  const CustomJobBoardsCard(
      {Key? key,
      this.image,
      this.color,
      this.descColor,
      this.onTap,
      this.price,
      this.desc,
      this.priceColor,
      this.heading,
      this.index,
      this.sIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image.toString()),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: sIndex == index
                          ? Image.asset(
                              MyImages.verified,
                              height: 20,
                              width: 20,
                            )
                          : Container(
                              // height: 15,
                              // width: 15,
                              decoration: BoxDecoration(
                                color: MyColors.blue.withOpacity(.20),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: SizedBox(),
                              ),
                            ),
                    ),
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      CommonText(
                        text: heading ?? "Enterprise",
                        fontColor: color ?? MyColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: priceColor ?? MyColors.white.withOpacity(.20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CommonText(
                                fontSize: 14,
                                text: price ?? "Contact Us",
                                fontColor: color ?? MyColors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      CommonText(
                        fontSize: 12,
                        text: desc ?? "Unlimited job parts",
                        fontColor: descColor ?? MyColors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              // Image.asset(MyImages.rateYellow)
            ],
          ),
        ),
      ),
    );
  }
}

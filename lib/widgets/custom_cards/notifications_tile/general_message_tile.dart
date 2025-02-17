// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';

import '../../../utils/my_images.dart';

class GeneralMessageTile extends StatelessWidget {
  final String? oppId;
  final String? selfId;
  const GeneralMessageTile({Key? key, this.oppId, this.selfId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          CustomCommonCard(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                              radius: 20,
                              backgroundImage: CachedNetworkImageProvider("")),
                          Positioned(
                              bottom: 5,
                              left: 67,
                              child: Container(
                                padding: EdgeInsets.all(3.5),
                                decoration: BoxDecoration(
                                    color: MyColors.blue,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 13,
                                  color: MyColors.blue,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "username: $oppId",
                            fontWeight: FontWeight.w500,
                          ),
                          CommonText(
                            text: "1 Minute ago",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ],
                      ),
                      Spacer(),
                      // Container(
                      //   height: 25,
                      //   width: 25,
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: MyColors.blue,
                      //   ),
                      //   child: CommonText(
                      //     text: "1",
                      //     fontWeight: FontWeight.w400,
                      //     fontColor: MyColors.white,
                      //     fontSize: 13,
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.lightGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommonText(
                            text: "Senior Developer Position",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            fontColor: MyColors.green,
                          ),
                          SizedBox(width: 10),
                          ImageButton(
                            image: MyImages.cancelGreen,
                            padding: EdgeInsets.zero,
                            height: 17,
                            width: 17,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          divider()
        ],
      ),
    );
  }
}

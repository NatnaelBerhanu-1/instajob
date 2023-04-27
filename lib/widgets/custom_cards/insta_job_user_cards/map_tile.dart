// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../../utils/my_colors.dart';
import '../../../utils/my_images.dart';

class MapTile extends StatelessWidget {
  const MapTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.20),
            spreadRadius: 4,
            blurRadius: 7,
          )
        ],
      ),
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyColors.white,
              image: DecorationImage(
                  image: AssetImage(MyImages.staffMeeting), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: CustomCommonCard(
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "15 mi",
                  style: TextStyle(color: MyColors.blue, fontSize: 13),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height * 0.157,
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                  // padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.comfortable,
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: MyColors.white,
                  )),
            ),
          ),
          Positioned(
            left: 0,
            top: MediaQuery.of(context).size.height * 0.18,
            child: Row(
              children: [
                ImageButton(
                    image: MyImages.locationBlue, height: 18, width: 18),
                Text(
                  "274 whaston ave. ann",
                  style: TextStyle(color: MyColors.blue, fontSize: 13),
                ),
              ],
            ),
          ),
          Positioned(
            left: 12,
            bottom: 39,
            child: Text(
              "Senior Developer",
              style: TextStyle(fontSize: 14),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 9,
            child: Row(
              children: [
                CustomCommonCard(
                  bgColor: MyColors.lightBlue.withOpacity(.20),
                  borderRadius: BorderRadius.circular(5),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CommonText(
                      text: "Full Time",
                      fontSize: 12,
                      fontColor: MyColors.blue,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CustomCommonCard(
                  bgColor: Colors.cyan.withOpacity(.20),
                  borderRadius: BorderRadius.circular(5),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CommonText(
                      text: "60k+",
                      fontSize: 12,
                      fontColor: Colors.cyan,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CustomCommonCard(
                  bgColor: Colors.purpleAccent.withOpacity(.30),
                  borderRadius: BorderRadius.circular(5),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CommonText(
                      text: "Senior Level",
                      fontSize: 12,
                      fontColor: Colors.purpleAccent,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget buildMapTile() {
  return SizedBox(
    height: 255,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (c, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: MapTile(),
          );
        }),
  );
}

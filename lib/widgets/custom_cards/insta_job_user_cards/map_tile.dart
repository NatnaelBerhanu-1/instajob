// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../../utils/my_colors.dart';
import '../../../utils/my_images.dart';

class MapTile extends StatelessWidget {
  final JobDistanceModel jobDistanceModel;
  const MapTile({Key? key, required this.jobDistanceModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.72,
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
          CachedNetworkImage(
            imageUrl:
                "${EndPoint.imageBaseUrl}${jobDistanceModel.companyUploadPhoto}",
            fit: BoxFit.cover,
            imageBuilder: (c, val) {
              return Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.white,
                  image: DecorationImage(
                      image: NetworkImage(
                          "${EndPoint.imageBaseUrl}${jobDistanceModel.companyUploadPhoto}"),
                      fit: BoxFit.cover),
                ),
              );
            },
            placeholder: (val, _) {
              return SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()));
            },
          ),
          Positioned(
            right: 10,
            top: 10,
            child: CustomCommonCard(
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "${jobDistanceModel.areaDistance} mi",
                  style: TextStyle(color: MyColors.blue, fontSize: 13),
                ),
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 80,
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: MyColors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                  // padding: EdgeInsets.zero,
                  // visualDensity: VisualDensity.comfortable,
                  visualDensity: VisualDensity.comfortable,
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: MyColors.white,
                    size: 20,
                  )),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 52,
            child: Row(              
              children: [
                ImageButton(
                    image: MyImages.locationBlue, height: 18, width: 12),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.44,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "${jobDistanceModel.cAddress}",
                        style: TextStyle(
                            color: MyColors.blue,
                            fontSize: 9,
                            // overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 12,
            bottom: 39,
            child: Text(
              "${jobDistanceModel.designation}",
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
                      text: "${jobDistanceModel.jobsType}",
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
                      text: "${jobDistanceModel.salaries}k+",
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
                      text: "${jobDistanceModel.experienceLevel}",
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

/*Widget buildMapTile() {
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
}*/

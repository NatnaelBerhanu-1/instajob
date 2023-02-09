// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../../../widgets/custom_cards/insta_job_user_cards/occupation_details_tile.dart';

class OccupationDetailsScreen extends StatefulWidget {
  const OccupationDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OccupationDetailsScreen> createState() =>
      _OccupationDetailsScreenState();
}

class _OccupationDetailsScreenState extends State<OccupationDetailsScreen> {
  List<String> list = [
    "Specific Information",
    "Occupational Requirement",
    "Experience Requirement",
    "Worker Requirement",
    "Worker Characteristics",
  ];
  int sIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              color: MyColors.lightBlue.withOpacity(.20),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: List.generate(
                      list.length,
                      (index) => GestureDetector(
                            onTap: () {
                              sIndex = index;
                              setState(() {});
                            },
                            child: CustomCommonCard(
                              bgColor: sIndex == index
                                  ? MyColors.blue
                                  : MyColors.transparent,
                              borderRadius: sIndex == index
                                  ? BorderRadius.circular(10)
                                  : BorderRadius.circular(0),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  list[index],
                                  style: TextStyle(
                                    color: sIndex == index
                                        ? MyColors.white
                                        : MyColors.blue,
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OccupationDetailTile(
                        heading: "Activities",
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('data'),
                        )),
                  );
                }),
          )
        ],
      ),
    ));
  }
}

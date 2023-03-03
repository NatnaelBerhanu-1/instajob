// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/changeValue_bloc.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../../../widgets/custom_app_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    var selectedIndex = context.watch<IndexBloc>().sIndex;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Occupation Details",
            )),
        body: SafeArea(
          child: BlocBuilder<IndexBloc, IndexState>(builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: "Set and Exhibit Designer",
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 10),
                  CommonText(
                    text: "27-1027.00",
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ImageButton(
                        image: MyImages.cal,
                        padding: EdgeInsets.zero,
                        color: MyColors.grey,
                      ),
                      SizedBox(width: 5),
                      CommonText(
                        text: "Updated 2022",
                        fontSize: 13,
                        fontColor: MyColors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.lightBlue.withOpacity(.20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: List.generate(
                              list.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      context
                                          .read<IndexBloc>()
                                          .changeIndex(index);
                                      // leaveSheet(context);
                                    },
                                    child: CustomCommonCard(
                                      bgColor: selectedIndex == index
                                          ? MyColors.blue
                                          : MyColors.transparent,
                                      borderRadius: selectedIndex == index
                                          ? BorderRadius.circular(10)
                                          : BorderRadius.circular(0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          list[index],
                                          style: TextStyle(
                                            color: context
                                                        .watch<IndexBloc>()
                                                        .sIndex ==
                                                    index
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
                  SizedBox(height: 10),
                  if (selectedIndex == 0) ...[
                    Expanded(
                      child: ListView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return OccupationDetailTile(
                                heading: "Activities",
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('data'),
                                ));
                          }),
                    )
                  ] else if (selectedIndex == 1) ...[
                    Expanded(
                      child: ListView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return OccupationDetailTile(
                                heading: "Work Activities",
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('data'),
                                ));
                          }),
                    )
                  ] else if (selectedIndex == 2) ...[
                    Expanded(
                      child: ListView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return OccupationDetailTile(
                                heading: "Skills",
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('data'),
                                ));
                          }),
                    )
                  ] else if (selectedIndex == 3) ...[
                    Expanded(
                      child: ListView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return OccupationDetailTile(
                                heading: "Abilities",
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('data'),
                                ));
                          }),
                    )
                  ] else if (selectedIndex == 4) ...[
                    Expanded(
                      child: ListView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return OccupationDetailTile(
                                heading: "Wages & Employment Trends",
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('data'),
                                ));
                          }),
                    )
                  ]
                ],
              ),
            );
          }),
        ));
  }
}

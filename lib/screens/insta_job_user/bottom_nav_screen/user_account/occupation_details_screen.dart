// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/changeValue_bloc.dart';
import 'package:insta_job/bottom_sheet/bottom_sheet.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/notifications_tile/message_tile.dart';

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
  // int sIndex = 0;
  @override
  Widget build(BuildContext context) {
    var blocData = context.read<IndexBloc>().sIndex;
    return Scaffold(
        body: SafeArea(
      child: BlocBuilder<IndexBloc, InitialState>(
          buildWhen: (p, c) => p != c,
          builder: (context, state) {
            return Column(
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
                                    context
                                        .read<IndexBloc>()
                                        .add(ChangeIndex(index));
                                    print(" BLOC INDEX -> $blocData");
                                    leaveSheet(context);
                                    // sIndex = index;
                                    // setState(() {});
                                  },
                                  child: CustomCommonCard(
                                    bgColor: blocData == index
                                        ? MyColors.blue
                                        : MyColors.transparent,
                                    borderRadius: blocData == index
                                        ? BorderRadius.circular(10)
                                        : BorderRadius.circular(0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        list[index],
                                        style: TextStyle(
                                          color: blocData == index
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
                if (blocData == 0) ...[
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
                ] else if (blocData == 1) ...[
                  Expanded(
                    child: ListView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        itemBuilder: (c, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MessageTile(),
                          );
                        }),
                  )
                ]
              ],
            );
          }),
    ));
  }
}

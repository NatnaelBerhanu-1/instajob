// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_bloc.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_state.dart';
import 'package:insta_job/model/career_learning_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../../../bloc/global_cubit/global_cubit.dart';
import '../../../../bloc/global_cubit/global_state.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_cards/insta_job_user_cards/occupation_details_tile.dart';

class OccupationDetailsScreen extends StatefulWidget {
  final ClusterDetailsModel? clusterDetailsModel;
  const OccupationDetailsScreen({Key? key, this.clusterDetailsModel})
      : super(key: key);

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
    "WorkForce Characteristics",
  ];

  @override
  void initState() {
    context.read<CareerLearningBloc>().getTaskList(
          code: widget.clusterDetailsModel!.code.toString(),
        );
    context.read<CareerLearningBloc>().getTechList(
          code: widget.clusterDetailsModel!.code.toString(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var selectedIndex = context.watch<GlobalCubit>().sIndex;
    var careerModel = context.read<CareerLearningBloc>().careerClusterModel;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Occupation Details",
            )),
        body: SafeArea(
          child:
              BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                  buildWhen: (previous, current) =>
                      current is DetailLoaded && previous != current,
                  builder: (context, clusterState) {
                    return clusterState is CareerLeaningLoading
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              clusterState is DetailLoaded
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonText(
                                          text: "${clusterState.data.title}",
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 10),
                                        CommonText(
                                          text: "${clusterState.data.code}",
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
                                              text:
                                                  "Updated ${clusterState.data.updated?.year}",
                                              fontSize: 13,
                                              fontColor: MyColors.grey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
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
                                                      .read<GlobalCubit>()
                                                      .changeIndex(index);
                                                  // context
                                                  //     .read<
                                                  //         CareerLearningBloc>()
                                                  // .getDetailList(
                                                  //     url: context
                                                  //         .read<
                                                  //             CareerLearningBloc>()
                                                  //         .careerClusterModel
                                                  //         .summaryResources!
                                                  //         .resource![index]
                                                  //         .href
                                                  //         .toString());
                                                },
                                                child: CustomCommonCard(
                                                  bgColor: selectedIndex ==
                                                          index
                                                      ? MyColors.blue
                                                      : MyColors.transparent,
                                                  borderRadius: selectedIndex ==
                                                          index
                                                      ? BorderRadius.circular(
                                                          10)
                                                      : BorderRadius.circular(
                                                          0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      list[index],
                                                      style: TextStyle(
                                                        color: context
                                                                    .watch<
                                                                        GlobalCubit>()
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
                                Expanded(child: BlocBuilder<CareerLearningBloc,
                                        InitialCareerLearning>(
                                    builder: (context, taskState) {
                                  var careerData =
                                      context.read<CareerLearningBloc>();
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        OccupationDetailTile(
                                            heading: "Tasks",
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: SizedBox(
                                                height: 230,
                                                child: taskState
                                                        is CareerLeaningLoading
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : ListView.builder(
                                                        itemCount: careerData
                                                            .taskList.length,
                                                        // shrinkWrap: true,
                                                        itemBuilder: (c, i) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        5.0,
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                    flex: 0,
                                                                    child: Text(
                                                                        "•  ")),
                                                                Expanded(
                                                                  child: Text(
                                                                      '${careerData.taskList[i].name}'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                              ),
                                            )),
                                        SizedBox(height: 15),
                                        OccupationDetailTile(
                                            heading: "Technology Skills",
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: SizedBox(
                                                child: ListView.builder(
                                                    itemCount: careerData
                                                        .techSkillList.length,
                                                    shrinkWrap: true,
                                                    itemBuilder: (c, i) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5.0,
                                                                horizontal: 10),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                                flex: 0,
                                                                child: Text(
                                                                    "•  ")),
                                                            Expanded(
                                                              child: Text(
                                                                  '${careerData.techSkillList[i].title?.name}'),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            )),
                                      ],
                                    ),
                                  );
                                }))
                              ] else if (selectedIndex == 1) ...[
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: 6,
                                      shrinkWrap: true,
                                      itemBuilder: (c, i) {
                                        return OccupationDetailTile(
                                            heading: "Work Activities",
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                            heading:
                                                "Wages & Employment Trends",
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text('data'),
                                            ));
                                      }),
                                )
                              ]
                            ],
                          );
                  }),
            );
          }),
        ));
  }
}

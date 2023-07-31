// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_bloc.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_state.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/cluster_widget/occupation_details_tile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SpecificInfoTile extends StatelessWidget {
  const SpecificInfoTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child:
        BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
            builder: (context, taskState) {
      var careerData = context.read<CareerLearningBloc>();
      return SingleChildScrollView(
        child: Column(
          children: [
            OccupationDetailTile(
                heading: "Tasks",
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: taskState is CareerLeaningLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: careerData.taskList.length,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 0, child: Text("•  ")),
                                Expanded(
                                  child: Text('${careerData.taskList[i].name}'),
                                ),
                              ],
                            );
                          }),
                )),
            OccupationDetailTile(
                heading: "Technology Skills",
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    child: ListView.builder(
                        itemCount: careerData.techSkillList.length,
                        shrinkWrap: true,
                        itemBuilder: (c, i) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 0, child: Text("•  ")),
                              Expanded(
                                child: Text(
                                    '${careerData.techSkillList[i].title?.name}'),
                              ),
                            ],
                          );
                        }),
                  ),
                )),
          ],
        ),
      );
    }));
  }
}

class OccupationalReqTile extends StatelessWidget {
  const OccupationalReqTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                buildWhen: (previous, current) =>
                    current is WorkActivityLoaded && previous != current,
                builder: (context, workActivityState) {
                  return OccupationDetailTile(
                      heading: "Work Activities",
                      child: workActivityState is CareerLeaningLoading
                          ? Center(child: CircularProgressIndicator())
                          : workActivityState is WorkActivityLoaded
                              ? ListView.builder(
                                  itemCount: workActivityState.list.length,
                                  shrinkWrap: true,
                                  itemBuilder: (c, i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 0, child: Text("•  ")),
                                              Expanded(
                                                child: Text(
                                                  '${workActivityState.list[i].name} :',
                                                  style: TextStyle(
                                                      // fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25.0),
                                                  child: Text(
                                                    '${workActivityState.list[i].description}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : SizedBox());
                }),
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                buildWhen: (previous, current) =>
                    current is DetailWorkActivityLoaded && previous != current,
                builder: (context, workActivityState) {
                  return OccupationDetailTile(
                      heading: "Detail Work Activities",
                      child: workActivityState is CareerLeaningLoading
                          ? Center(child: CircularProgressIndicator())
                          : workActivityState is DetailWorkActivityLoaded
                              ? ListView.builder(
                                  itemCount: workActivityState.list.length,
                                  shrinkWrap: true,
                                  itemBuilder: (c, i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(flex: 0, child: Text("•  ")),
                                          Expanded(
                                            child: Text(
                                                '${workActivityState.list[i].name}'),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : SizedBox());
                }),
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                buildWhen: (previous, current) =>
                    current is WorkContextLoaded && previous != current,
                builder: (context, workContextState) {
                  return OccupationDetailTile(
                      heading: "Work Context",
                      child: workContextState is CareerLeaningLoading
                          ? Center(child: CircularProgressIndicator())
                          : workContextState is WorkContextLoaded
                              ? ListView.builder(
                                  itemCount: workContextState.list.length,
                                  shrinkWrap: true,
                                  itemBuilder: (c, i) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(flex: 0, child: Text("•  ")),
                                          Expanded(
                                            child: Text(
                                              '${workContextState.list[i].name}',
                                            ),
                                          ),
                                          //  : ${workContextState.list[i].response!.isEmpty || workContextState.list[i].response == null ? "" : "${workContextState.list[i].response?[0].percentage}% responded ''${workContextState.list[i].response?[0].name}''"}
                                        ],
                                      ),
                                    );
                                  })
                              : SizedBox());
                }),
          ],
        ),
      ),
    );
  }
}

class WorkCharTile extends StatelessWidget {
  const WorkCharTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                buildWhen: (previous, current) =>
                    current is WorkActivityLoaded && previous != current,
                builder: (context, state) {
                  return OccupationDetailTile(
                      heading: "Abilities",
                      child: state is CareerLeaningLoading
                          ? Center(child: CircularProgressIndicator())
                          : state is WorkActivityLoaded
                              ? ListView.builder(
                                  itemCount: state.list.length,
                                  shrinkWrap: true,
                                  itemBuilder: (c, i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonText(
                                              text: "${state.list[i].name} :",
                                              fontWeight: FontWeight.bold),
                                          SizedBox(height: 3),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CommonText(
                                                  text:
                                                      "${state.list[i].description}",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : SizedBox());
                }),
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                buildWhen: (previous, current) =>
                    current is WorkContextLoaded && previous != current,
                builder: (context, state) {
                  return OccupationDetailTile(
                      heading: "Interest",
                      child: state is CareerLeaningLoading
                          ? Center(child: CircularProgressIndicator())
                          : state is WorkContextLoaded
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: ListView.builder(
                                      itemCount: state.list.length,
                                      // shrinkWrap: true,
                                      itemBuilder: (c, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonText(
                                                  text:
                                                      "${state.list[i].name} :",
                                                  fontWeight: FontWeight.bold),
                                              SizedBox(height: 3),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CommonText(
                                                      text:
                                                          "${state.list[i].description}",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox());
                }),
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                buildWhen: (previous, current) =>
                    current is KnowledgeLoaded && previous != current,
                builder: (context, state) {
                  return OccupationDetailTile(
                      heading: "Work Values",
                      child: state is CareerLeaningLoading
                          ? Center(child: CircularProgressIndicator())
                          : state is KnowledgeLoaded
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: ListView.builder(
                                      itemCount: state.list.length,
                                      // shrinkWrap: true,
                                      itemBuilder: (c, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonText(
                                                  text:
                                                      "${state.list[i].name} :",
                                                  fontWeight: FontWeight.bold),
                                              SizedBox(height: 3),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CommonText(
                                                      text:
                                                          "${state.list[i].description}",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox());
                }),
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                buildWhen: (previous, current) =>
                    current is WorkStyleLoaded && previous != current,
                builder: (context, state) {
                  return OccupationDetailTile(
                      heading: "Work Style",
                      child: state is CareerLeaningLoading
                          ? Center(child: CircularProgressIndicator())
                          : state is WorkStyleLoaded
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: ListView.builder(
                                      itemCount: state.list.length,
                                      // shrinkWrap: true,
                                      itemBuilder: (c, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonText(
                                                  text:
                                                      "${state.list[i].name} :",
                                                  fontWeight: FontWeight.bold),
                                              SizedBox(height: 3),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CommonText(
                                                      text:
                                                          "${state.list[i].description}",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox());
                }),
          ],
        ),
      ),
    );
  }
}

class WorkerReqTile extends StatelessWidget {
  const WorkerReqTile({
    super.key,
    this.code,
  });
  final String? code;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                buildWhen: (previous, current) {
              print("111111 $previous");
              print("222222 $current");
              return current is WorkContextLoaded && previous != current;
            }, builder: (context, skillData) {
              return OccupationDetailTile(
                  heading: "Skills",
                  child: skillData is CareerLeaningLoading
                      ? Center(child: CircularProgressIndicator())
                      : skillData is WorkContextLoaded
                          ? ListView.builder(
                              itemCount: skillData.list.length,
                              shrinkWrap: true,
                              itemBuilder: (c, i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                          text: "${skillData.list[i].name}",
                                          fontWeight: FontWeight.bold),
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CommonText(
                                              text:
                                                  "${skillData.list[i].description}",
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : SizedBox());
            }),
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                buildWhen: (previous, current) {
              print("PRRRRRRRR $previous");
              print("CCCCCCCCCC $current");
              return current is KnowledgeLoaded && previous != current;
            }, builder: (context, skillData) {
              return OccupationDetailTile(
                  heading: "Knowledge",
                  child: skillData is CareerLeaningLoading
                      ? Center(child: CircularProgressIndicator())
                      : skillData is KnowledgeLoaded
                          ? ListView.builder(
                              itemCount: skillData.list.length,
                              shrinkWrap: true,
                              itemBuilder: (c, i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                          text: "${skillData.list[i].name}",
                                          fontWeight: FontWeight.bold),
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CommonText(
                                              text:
                                                  "${skillData.list[i].description}",
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : SizedBox());
            }),
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                buildWhen: (previous, current) {
              print("PRRRRRRRR $previous");
              print("CCCCCCCCCC $current");
              return current is EduLoaded && previous != current;
            }, builder: (context, skillData) {
              return OccupationDetailTile(
                  heading: "Education",
                  child: skillData is CareerLeaningLoading
                      ? Center(child: CircularProgressIndicator())
                      : skillData is EduLoaded
                          ? ListView.builder(
                              itemCount: skillData.list.length,
                              shrinkWrap: true,
                              itemBuilder: (c, i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 5),
                                  child: Row(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    children: [
                                      skillData.list[i].score == null
                                          ? SizedBox()
                                          : Expanded(
                                              flex: 0,
                                              child: CommonText(
                                                text:
                                                    "${skillData.list[i].score?.value}%",
                                                fontSize: 14,
                                              ),
                                            ),
                                      skillData.list[i].score == null
                                          ? SizedBox()
                                          : Expanded(
                                              flex: 0,
                                              child: LinearPercentIndicator(
                                                width: 100.0,
                                                animation: true,
                                                animationDuration: 1000,
                                                lineHeight: 10.0,
                                                backgroundColor:
                                                    MyColors.lightBl,
                                                percent: double.parse(skillData
                                                        .list[i].score!.value
                                                        .toString()) /
                                                    100,
                                                barRadius: Radius.circular(5),
                                                progressColor: MyColors.blue,
                                              )),
                                      Expanded(
                                        child: CommonText(
                                          text: "${skillData.list[i].name}",
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : SizedBox());
            }),
          ],
        ),
      ),
    );
  }
}

class ExpReqTile extends StatelessWidget {
  const ExpReqTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                builder: (context, jobZone) {
              return OccupationDetailTile(
                  heading: "JobZone",
                  child: jobZone is CareerLeaningLoading
                      ? Center(child: CircularProgressIndicator())
                      : jobZone is JobZoneLoaded
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                      text: "Title:",
                                      fontWeight: FontWeight.bold),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CommonText(
                                          text: "${jobZone.data.title}",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  CommonText(
                                      text: "Education:",
                                      fontWeight: FontWeight.bold),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CommonText(
                                          text: "${jobZone.data.education}",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  CommonText(
                                      text: "Related Experience:",
                                      fontWeight: FontWeight.bold),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CommonText(
                                          text:
                                              "${jobZone.data.relatedExperience}",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  CommonText(
                                      text: "Job Training:",
                                      fontWeight: FontWeight.bold),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CommonText(
                                          text: "${jobZone.data.jobTraining}",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  CommonText(
                                      text: "Job Zone Example:",
                                      fontWeight: FontWeight.bold),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CommonText(
                                          text:
                                              "${jobZone.data.jobZoneExamples}",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            )
                          : SizedBox());
            }),
          ],
        ),
      ),
    );
  }
}

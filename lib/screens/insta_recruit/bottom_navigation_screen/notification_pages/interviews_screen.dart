// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/notifications_tile/interview_tile.dart';
import 'package:insta_job/widgets/custom_cards/notifications_tile/message_tile.dart';

import '../../../../widgets/custom_cards/custom_common_card.dart';

class InterviewScreen extends StatefulWidget {
  const InterviewScreen({Key? key}) : super(key: key);

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 0,
          backgroundColor: MyColors.white,
          title: CommonText(
            text: tabIndex == 0 ? "Interviews" : "Interview Recordings",
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: TabBar(
                          unselectedLabelColor: MyColors.tabClr,
                          labelColor: MyColors.blue,
                          indicatorColor: MyColors.blue,
                          onTap: (val) {
                            tabIndex = val;
                            setState(() {});
                          },
                          tabs: [
                            Tab(text: "Upcoming"),
                            Tab(text: "Previous"),
                          ]),
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              child: InterviewTile(),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 3 / 8),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              child: InterviewTile(isRecording: true),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 3 / 8),
                        ),
                      ),
                    ]))
                  ],
                ),
              ),
            ),
            // SizedBox(height: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: "Messages",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            SizedBox(height: 6),
                            CommonText(
                              text: "All messages",
                              fontSize: 13,
                              fontColor: MyColors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: BlocBuilder<JobPositionBloc, JobPosState>(
                        builder: (context, state) {
                      if (state is AppliedJobLoaded) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.appliedJobList.length,
                            itemBuilder: (c, i) {
                              var data = state.appliedJobList[i];
                              return MessageTile(jobPosModel: data);
                            });
                      }
                      if (state is ApplyLoading) {
                        Center(child: CircularProgressIndicator());
                      }
                      if (state is ApplyErrorState) {
                        Center(child: Text(state.error));
                      }
                      return SizedBox();
                    }),
                  ),
                  /*SizedBox(
                    height: 250,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (c, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: MessageTile(),
                        );
                      },
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ));
  }
}
/*if (state is AppliedJobLoaded) ...[
Padding(
padding: const EdgeInsets.all(8.0),
child: GridView.builder(
itemCount: state.appliedJobList.length,
itemBuilder: (c, i) {
return GestureDetector(
onTap: () {
AppRoutes.push(
context,
JobPositionScreen(
jobPosModel:
state.appliedJobList[i]));
},
child: Padding(
padding: const EdgeInsets.symmetric(
horizontal: 5, vertical: 8),
child: AppliedTile(
// isAppliedTab: true,
jobPosModel:
state.appliedJobList[i]),
),
);
},
gridDelegate:
SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
crossAxisSpacing: 0,
mainAxisSpacing: 0,
childAspectRatio: 5.5 / 4.5),
),
)
],
if (state is ApplyErrorState) ...[
Center(child: Text(state.error))
],
if (state is ApplyLoading) ...[
Center(child: CircularProgressIndicator()),
],*/

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/auth_service.dart';
import 'package:insta_job/bloc/interview_schedule_cubit/interview_schedule_cubit.dart';
import 'package:insta_job/bloc/interview_schedule_cubit/interview_schedule_state.dart';
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
  void initState() {
    super.initState();
    context.read<InterviewScheduleCubit>().getInterviewSchedules();
  }

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
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          unselectedLabelColor: MyColors.tabClr,
                          labelColor: MyColors.blue,
                          indicatorColor: MyColors.blue,
                          onTap: (val) {
                            tabIndex = val;
                            context
                                .read<InterviewScheduleCubit>()
                                .getInterviewSchedules();
                            setState(() {});
                          },
                          tabs: [
                            Tab(text: "Upcoming"),
                            Tab(text: "Previous"),
                          ]),
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      _buildUpcomingInterviewTabDetails(),
                      _buildPreviousInterviewTabDetails(),
                    ]))
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: "Messages",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            SizedBox(height: 4),
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
                        //TODO: run and check (URGENT)
                        // return ListView.builder(
                        //     shrinkWrap: true,
                        //     itemCount: state.appliedJobList.length,
                        //     itemBuilder: (c, i) {
                        //       var data = state.appliedJobList[i];
                        //       return MessageTile(
                        //         jobPosModel: data,
                        //       );
                        //     });

                        return StreamBuilder<Object>(
                            stream: FirebaseFirestore.instance
                                .collection(AuthService.chatCollection)
                                // .where("jobId", isEqualTo: jobId)
                                .snapshots(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                debugPrint(
                                    'chats: ${snapshot.data.docs.map((e) => e.data() as Map<String, dynamic>)}');
                                var chats =
                                    (snapshot.data as QuerySnapshot).docs;
                                return ListView.builder(
                                    itemCount: chats.length,
                                    itemBuilder: (context, index) =>
                                        MessageTile(
                                          jobPosModel: state.appliedJobList
                                              .firstWhere((element) =>
                                                  element.userFirebaseId
                                                      ?.toString() ==
                                                  chats[index].get('oppId')),
                                        ));
                              }
                              return SizedBox();
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

  Widget _buildPreviousInterviewTabDetails() {
    return BlocBuilder<InterviewScheduleCubit, InterviewScheduleState>(
        builder: (context, state) {
      if (state is InterviewScheduleLoading) {
        return _buildInterviewScheduleTabDetailsLoading();
      }
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          padding: EdgeInsets.only(bottom: 8),
          itemBuilder: (c, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              child: InterviewTile(isRecording: true),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 5,
            childAspectRatio: 3 / 7,
          ),
        ),
      );
    }
    );
  }

  Widget _buildUpcomingInterviewTabDetails() {
    return BlocBuilder<InterviewScheduleCubit, InterviewScheduleState>(
        builder: (context, state) {
      if (state is InterviewScheduleLoading) {
        return _buildInterviewScheduleTabDetailsLoading();
      }
      return Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(bottom: 8),
              itemCount: 4,
              itemBuilder: (c, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: InterviewTile(),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 5,
                childAspectRatio: 3 / 7,
              ),
            ),
            const SizedBox(height: 12),
            // Center(
            // child: DotsIndicator(
            //   dotsCount: 5,
            //   position: 3,
            //   decorator: const DotsDecorator(
            //     color: ColorUtils.darkGrey,
            //     activeColor: ColorUtils.white,
            //     size: Size(6, 6),
            //     activeSize: Size(8, 8),
            //   ),
            // ),
            // child: DotsIndicator(
            //   dotsCount: 4, // Total number of pages
            //   position: _currentPage.toDouble(),
            //   decorator: DotsDecorator(
            //     size: const Size.square(8.0),
            //     activeSize: const Size(20.0, 8.0),
            //     activeShape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //   ),
            // ),
            // ),
          ],
        ),
      );
    });
  }

  Center _buildInterviewScheduleTabDetailsLoading() {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(),
      ),
    );
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

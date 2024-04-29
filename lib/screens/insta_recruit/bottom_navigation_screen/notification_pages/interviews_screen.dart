// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/auth_service.dart';
import 'package:insta_job/bloc/interview_schedule_cubit/interview_schedule_cubit.dart';
import 'package:insta_job/bloc/interview_schedule_cubit/interview_schedule_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/chat_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/notifications_tile/general_message_tile.dart';
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
    context.read<InterviewScheduleCubit>().getInterviewSchedules(Global.userModel!.id.toString());
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
                    TabBar(
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        unselectedLabelColor: MyColors.tabClr,
                        labelColor: MyColors.blue,
                        indicatorColor: MyColors.blue,
                        onTap: (val) {
                          tabIndex = val;
                          context.read<InterviewScheduleCubit>().getInterviewSchedules(Global.userModel!.id.toString());
                          setState(() {});
                        },
                        tabs: [
                          Tab(text: "Upcoming"),
                          Tab(text: "Previous"),
                        ]),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildUpcomingInterviewTabDetails(),
                          _buildPreviousInterviewTabDetails(),
                        ],
                      ),
                    )
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
                      child: StreamBuilder<Object>(
                          stream: FirebaseFirestore.instance
                              .collection(AuthService.chatCollection)
                              .where(Global.userModel?.type == "user" ? 'oppId' : 'selfId',
                                  isEqualTo: Global.userModel?.firebaseId)
                              .snapshots(),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            debugPrint('Type: ${Global.userModel?.type}');
                            debugPrint('firebaseID: ${Global.userModel?.firebaseId}');
                            if (snapshot.hasData) {
                              debugPrint('chats: ${snapshot.data.docs.map((e) => e.data() as Map<String, dynamic>)}');
                              var chats = (snapshot.data as QuerySnapshot).docs;
                              if (chats.isEmpty) {
                                return Center(child: Text('No Messages.'));
                              }
                              return ListView.builder(
                                  itemCount: chats.length,
                                  itemBuilder: (context, index) {
                                    var chatItemDoc = chats[index];
                                    var chatModel = ChatModel.fromMap(chatItemDoc.data() as Map<String, dynamic>);
                                    return MessageTile(
                                      chatModel: chatModel,
                                    );
                                  });
                            }
                            return SizedBox.shrink();
                            // return Center(child: Text("No messages yet"));
                          })),
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
    return BlocBuilder<InterviewScheduleCubit, InterviewScheduleState>(builder: (context, state) {
      if (state is InterviewScheduleLoading) {
        return _buildInterviewScheduleTabDetailsLoading();
      } else if (state is InterviewScheduleSuccess) {
        if (state.pastSchedules.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.pastSchedules.length,
              padding: EdgeInsets.only(bottom: 8),
              itemBuilder: (c, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                  child: InterviewTile(isRecording: true, interviewModel: state.pastSchedules[i]),
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
        return Center(child: Text('No previous interviews.'));
      }
      return SizedBox();
    });
  }

  Widget _buildUpcomingInterviewTabDetails() {
    return BlocBuilder<InterviewScheduleCubit, InterviewScheduleState>(builder: (context, state) {
      if (state is InterviewScheduleLoading) {
        return _buildInterviewScheduleTabDetailsLoading();
      } else if (state is InterviewScheduleSuccess) {
        if (state.upcomingSchedules.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(bottom: 8),
              itemCount: state.upcomingSchedules.length,
              itemBuilder: (c, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: InterviewTile(
                    interviewModel: state.upcomingSchedules[i],
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 5,
                childAspectRatio: 3 / 8,
              ),
            ),
          );
        }
        return Center(child: Text('No upcomming interviews.'));
      }
      return SizedBox();
    });
  }

  Center _buildInterviewScheduleTabDetailsLoading() {
    return Center(
      child: SizedBox(
        height: 40,
        width: 40,
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

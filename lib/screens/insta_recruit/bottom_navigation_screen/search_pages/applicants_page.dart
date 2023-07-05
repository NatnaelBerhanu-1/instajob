// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/chat_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/resume_tile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Applicants extends StatefulWidget {
  final JobPosModel? jobPosModel;
  const Applicants({Key? key, this.jobPosModel}) : super(key: key);

  @override
  State<Applicants> createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  @override
  Widget build(BuildContext context) {
    var tab = context.watch<GlobalCubit>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppBar(
          imageColor: MyColors.blue,
          centerTitle: false,
          leadingImage: MyImages.backArrowBorder,
          height: 30,
          width: 30,
          title: "Applicants",
          onTap: () {
            // context
            //     .read<BottomCubit>()
            //     .setSelectedScreen(true, screenName: ViewCandidates());
            // context.read<BottomBloc>().add(SetScreenEvent(true,
            //     screenName: ViewCandidates(jobPosModel: widget.jobPosModel)));
            // AppRoutes.push(
            //     context, ViewCandidates(jobPosModel: widget.jobPosModel));
            Navigator.of(context).pop();
            tab.changeTabValue(0);
            context.read<JobPositionBloc>().add(AppliedJobListEvent(
                jobId: widget.jobPosModel!.id.toString(), status: "applied"));
            // context.read<ResumeBloc>().resumeModel = ResumeModel();
            // setState(() {});
            // AppRoutes.push(context, BottomNavScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinearPercentIndicator(
                    width: 170.0,
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 25.0,
                    backgroundColor: MyColors.lightBl,
                    percent: 0.87,
                    center: Text(
                      "90% Match",
                      style: TextStyle(fontSize: 12, color: MyColors.blue),
                    ),
                    barRadius: Radius.circular(5),
                    progressColor: Colors.blue.shade100,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: MyColors.grey.withOpacity(.10),
                              spreadRadius: 5,
                              blurRadius: 8)
                        ]),
                    child: SfPdfViewer.network(
                      "${EndPoint.imageBaseUrl}${widget.jobPosModel?.uploadResume}",
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 15),
              Expanded(
                flex: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                  child: BlocBuilder<JobPositionBloc, JobPosState>(
                      builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                            child: CustomButton(
                          height: MediaQuery.of(context).size.height * 0.055,
                          title: "Contact",
                          onTap: () {
                            AppRoutes.push(
                                context,
                                ChatScreen(
                                  jobPosModel: widget.jobPosModel,
                                  oppId: widget.jobPosModel!.userFirebaseId,
                                  selfId: Global.userModel?.firebaseId,
                                ));
                          },
                        )),
                        tab.selectedTab == 1 ? SizedBox() : SizedBox(width: 15),
                        tab.selectedTab == 1
                            ? SizedBox()
                            : Expanded(
                                child: CustomButton(
                                height:
                                    MediaQuery.of(context).size.height * 0.055,
                                title: "Shortlist",
                                bgColor: MyColors.cyan,
                                onTap: () {
                                  context.read<JobPositionBloc>().add(
                                      SortListOrDenyEvent(
                                          appliedListId:
                                              "${widget.jobPosModel?.appliedId}",
                                          status: "shortlisted"));
                                  AppRoutes.pop(context);
                                },
                              )),
                        tab.selectedTab == 4 ? SizedBox() : SizedBox(width: 15),
                        tab.selectedTab == 4
                            ? SizedBox()
                            : Expanded(
                                child: CustomButton(
                                height:
                                    MediaQuery.of(context).size.height * 0.055,
                                bgColor: MyColors.lightRed,
                                title: "Deny",
                              )),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: BlocBuilder<ResumeBloc, ResumeState>(
                    builder: (context, state) {
                  var resumeData = context.read<ResumeBloc>();
                  return DefaultTabController(
                      length: 5,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: MyColors.blue,
                            isScrollable: true,
                            unselectedLabelColor: MyColors.tabClr,
                            indicatorColor: MyColors.blue,
                            indicatorPadding:
                                EdgeInsets.symmetric(horizontal: 4),
                            tabs: [
                              Tab(text: "Bio"),
                              Tab(text: "Education"),
                              Tab(text: "Experience"),
                              Tab(text: "Skills"),
                              Tab(text: "Achievements"),
                            ],
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15),
                            child: TabBarView(
                              children: [
                                if (state is UserResumeLoaded) ...[
                                  Text(
                                      "${state.resumeModel.tellUss?[0].tellUs}"),
                                  ListView.builder(
                                      itemCount:
                                          state.resumeModel.educations?.length,
                                      shrinkWrap: true,
                                      itemBuilder: (c, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: ResumeTile(
                                            index: i + 1,
                                            educations: state
                                                .resumeModel.educations?[i],
                                          ),
                                        );
                                      }),
                                  ListView.builder(
                                      itemCount: state
                                          .resumeModel.workExperiences?.length,
                                      shrinkWrap: true,
                                      itemBuilder: (c, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: ResumeTile(
                                            index: i + 1,
                                            isWorkExp: true,
                                            workExperiences: state.resumeModel
                                                .workExperiences?[i],
                                          ),
                                        );
                                      }),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.resumeModel.skills?[0]
                                          .addSkill?.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: .0, horizontal: 0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${state.resumeModel.skills?[0].addSkill?[i]}",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    color: MyColors.blue,
                                                  ),
                                                ],
                                              ),
                                              divider()
                                            ],
                                          ),
                                        );
                                      }),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state
                                          .resumeModel
                                          .achievements?[0]
                                          .achievements
                                          ?.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: .0, horizontal: 0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${state.resumeModel.achievements?[0].achievements?[i]}",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    color: MyColors.blue,
                                                  ),
                                                ],
                                              ),
                                              divider()
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                                if (state is ErrorState) ...[
                                  Center(child: Text(state.error))
                                ],
                                if (state is ErrorState) ...[
                                  Center(child: Text(state.error))
                                ],
                                if (state is ErrorState) ...[
                                  Center(child: Text(state.error))
                                ],
                                if (state is ErrorState) ...[
                                  Center(child: Text(state.error))
                                ],
                                if (state is ErrorState) ...[
                                  Center(child: Text(state.error))
                                ],
                              ],
                            ),
                          ))
                        ],
                      ));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

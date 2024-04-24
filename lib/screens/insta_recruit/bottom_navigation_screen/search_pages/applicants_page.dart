// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/bloc/resume_details_cubit/resume_details_cubit.dart';
import 'package:insta_job/bloc/resume_details_cubit/resume_details_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/chat_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/model/resume_detail_model.dart';
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
  final List<JobPosModel> fullFilteredApplicantsList;
  final int selectedIndex;
  const Applicants({
    Key? key,
    required this.fullFilteredApplicantsList,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<Applicants> createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  late JobPosModel? jobPosModel;
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobPosModel = widget.fullFilteredApplicantsList[widget.selectedIndex];
    _pageController = PageController(initialPage: widget.selectedIndex);
    context.read<ResumeDetailsCubit>().execute(resumeUrl: jobPosModel?.uploadResume);
  }

  @override
  void dispose() {
    // Dispose the PageController when the widget is disposed
    _pageController.dispose();
    super.dispose();
  }

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
            //     screenName: ViewCandidates(jobPosModel: jobPosModel)));
            // AppRoutes.push(
            //     context, ViewCandidates(jobPosModel: jobPosModel));
            Navigator.of(context).pop();
            // tab.changeTabValue(0);
            // context.read<JobPositionBloc>().add(AppliedJobListEvent(
            //     jobId: jobPosModel!.id.toString(), status: "applied"));
            // context.read<ResumeBloc>().resumeModel = ResumeModel();
            // setState(() {});
            // AppRoutes.push(context, BottomNavScreen());
          },
        ),
      ),
      body: PageView.builder(
          controller: _pageController,
          onPageChanged: (i) {
            setState(() {
              jobPosModel = widget.fullFilteredApplicantsList[i];
              context.read<ResumeDetailsCubit>().execute(resumeUrl: jobPosModel?.uploadResume);
            });
          },
          itemCount: widget.fullFilteredApplicantsList.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
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
                          percent: (jobPosModel?.matchScore ?? 0) / 100,
                          center: Text(
                            "${jobPosModel?.matchScore ?? 0}% Match",
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
                                BoxShadow(color: MyColors.grey.withOpacity(.10), spreadRadius: 5, blurRadius: 8)
                              ]),
                          child: SfPdfViewer.network(
                            "${EndPoint.imageBaseUrl}${jobPosModel?.uploadResume}",
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 15),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                        child: BlocBuilder<JobPositionBloc, JobPosState>(builder: (context, state) {
                          return Row(
                            children: [
                              tab.selectedTab == 4
                                  ? SizedBox()
                                  : Expanded(
                                      child: CustomButton(
                                      height: MediaQuery.of(context).size.height * 0.055,
                                      bgColor: MyColors.darkRed,
                                      title: "Deny",
                                      onTap: () {
                                        context.read<JobPositionBloc>().add(SortListOrDenyEvent(
                                            appliedListId: "${jobPosModel?.appliedId}", status: "denied"));
                                        AppRoutes.pop(context);
                                      },
                                    )),
                              tab.selectedTab == 4 ? SizedBox() : SizedBox(width: 15),
                              Expanded(
                                  child: CustomButton(
                                height: MediaQuery.of(context).size.height * 0.055,
                                title: "Contact",
                                onTap: () {
                                  debugPrint('jobPosModel: ${jobPosModel?.toJson()}');
                                  AppRoutes.push(
                                      context,
                                      ChatScreen(
                                        // jobPosModel: jobPosModel,
                                        // oppId: jobPosModel!.userFirebaseId,
                                        // selfId: Global.userModel?.firebaseId,\
                                        chatModel: ChatModel(
                                            gp: "${Global.userModel?.firebaseId}_${jobPosModel!.userFirebaseId}",
                                            oppId: jobPosModel!.userFirebaseId,
                                            selfId: Global.userModel?.firebaseId,
                                            jobId: jobPosModel!.jobId,
                                            oppName: "${jobPosModel?.userName}",
                                            oppProfilePic: "${EndPoint.imageBaseUrl}${jobPosModel?.uploadPhoto}",
                                            selfName: "${jobPosModel?.empName}",
                                            selfProfilePic: "${EndPoint.imageBaseUrl}${jobPosModel?.uploadPhoto}",
                                            oppTitle: "${jobPosModel?.designation}"),
                                      ));
                                },
                              )),
                              tab.selectedTab == 1 ? SizedBox() : SizedBox(width: 15),
                              tab.selectedTab == 1
                                  ? SizedBox()
                                  : Expanded(
                                      child: CustomButton(
                                      height: MediaQuery.of(context).size.height * 0.055,
                                      title: "Shortlist",
                                      bgColor: MyColors.cyan,
                                      onTap: () {
                                        context.read<JobPositionBloc>().add(SortListOrDenyEvent(
                                            appliedListId: "${jobPosModel?.appliedId}", status: "shortlisted"));
                                        context.read<JobPositionBloc>().add(AppliedJobListEvent(
                                              jobId: jobPosModel!.id.toString(),
                                            ));
                                        AppRoutes.pop(context);
                                      },
                                    )),
                            ],
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 15),
                    Expanded(
                      child: BlocBuilder<ResumeBloc, ResumeState>(builder: (context, state) {
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
                                  indicatorPadding: EdgeInsets.symmetric(horizontal: 4),
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
                                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                                  child: TabBarView(
                                    children: [
                                      _buildBioSection(),
                                      _buildEducationSection(),
                                      _buildExperienceSection(),
                                      _buildSkillsSection(),
                                      _buildAchievementSection(),
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
            );
          }),
    );
  }

  _buildEducationSection() {
    return BlocBuilder<ResumeDetailsCubit, ResumeDetailsState>(builder: (context, state) {
      if (state is ResumeDetailsSuccess) {
        ResumeDetailModel resumeDetail = state.resumeDetail;
        List<EducationDetail>? educationDetailList = resumeDetail?.educationDetail;
        if (educationDetailList == null) {
          return Center(
            child: Text("No data"),
          );
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: educationDetailList.length,
            itemBuilder: (context, i) {
              var item = educationDetailList[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${i + 1}. ${item.name}",
                      style: TextStyle(fontSize: 14),
                    ),
                    divider()
                  ],
                ),
              );
            });
      }
      if (state is ResumeDetailsErrorState) {
        return Center(child: Text(state.message));
      }
      return SizedBox.shrink();
    });
  }

  _buildExperienceSection() {
    return BlocBuilder<ResumeDetailsCubit, ResumeDetailsState>(builder: (context, state) {
      if (state is ResumeDetailsSuccess) {
        ResumeDetailModel resumeDetail = state.resumeDetail;
        List<Experience>? experienceList = resumeDetail.experience;
        if (experienceList == null) {
          return Center(
            child: Text("No data"),
          );
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: experienceList.length,
            itemBuilder: (context, i) {
              var item = experienceList[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item.title}(${item.organization})",
                      style: TextStyle(fontSize: 14),
                    ),
                    divider()
                  ],
                ),
              );
            });
      }
      if (state is ResumeDetailsErrorState) {
        return Center(child: Text(state.message));
      }
      return SizedBox.shrink();
    });
  }

  _buildSkillsSection() {
    return BlocBuilder<ResumeDetailsCubit, ResumeDetailsState>(builder: (context, state) {
      if (state is ResumeDetailsSuccess) {
        ResumeDetailModel resumeDetail = state.resumeDetail;
        List<String>? skillsList = resumeDetail?.skills;
        if (skillsList == null || skillsList.isEmpty) {
          return Center(
            child: Text("No data"),
          );
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: skillsList.length,
            itemBuilder: (context, i) {
              var item = skillsList[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          item,
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Icon(
                          Icons.check_circle_outline_outlined,
                          color: MyColors.blue,
                        )
                      ],
                    ),
                    divider()
                  ],
                ),
              );
            });
      }
      if (state is ResumeDetailsErrorState) {
        return Center(child: Text(state.message));
      }
      return SizedBox.shrink();
    });
  }

  _buildAchievementSection() {
    return Center(child: Text("No Data Found"));
  }

  _buildBioSection() {
    return BlocBuilder<ResumeDetailsCubit, ResumeDetailsState>(builder: (context, state) {
      if (state is ResumeDetailsSuccess) {
        ResumeDetailModel resumeDetail = state.resumeDetail;
        String? name = resumeDetail.name;
        String? email = resumeDetail.email;
        String? address = resumeDetail.address;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name:\n$name",
              ),
              divider(),
              Text(
                "Email:\n$email",
              ),
              divider(),
              Text(
                "Address:\n$address",
              ),
              divider(),
            ],
          ),
        );
      }
      if (state is ResumeDetailsErrorState) {
        return Center(child: Text(state.message));
      }
      return SizedBox.shrink();
    });
  }

  _previousBuildMethod() {
    //temporarily kept for reference purposes, for reference and for UI
    return BlocBuilder<ResumeBloc, ResumeState>(builder: (context, state) {
      var resumeData = context.read<ResumeBloc>();
      if (state is! UserResumeLoaded) {
        return SizedBox();
      }
      return Column(
        children: [
          ...[
            Text("${state.resumeModel.tellUss?[0].tellUs}"),
            ListView.builder(
                itemCount: state.resumeModel.educations?.length,
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ResumeTile(
                      index: i + 1,
                      educations: state.resumeModel.educations?[i],
                    ),
                  );
                }),
            ListView.builder(
                itemCount: state.resumeModel.workExperiences?.length,
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ResumeTile(
                      index: i + 1,
                      isWorkExp: true,
                      workExperiences: state.resumeModel.workExperiences?[i],
                    ),
                  );
                }),
            ListView.builder(
                shrinkWrap: true,
                itemCount: state.resumeModel.skills?[0].addSkill?.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: .0, horizontal: 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${state.resumeModel.skills?[0].addSkill?[i]}",
                              style: TextStyle(fontSize: 14),
                            ),
                            Spacer(),
                            Icon(
                              Icons.check_circle_outline_rounded,
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
                itemCount: state.resumeModel.achievements?[0].achievements?.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: .0, horizontal: 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${state.resumeModel.achievements?[0].achievements?[i]}",
                              style: TextStyle(fontSize: 14),
                            ),
                            Spacer(),
                            Icon(
                              Icons.check_circle_outline_rounded,
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
        ],
      );
    });
  }
}

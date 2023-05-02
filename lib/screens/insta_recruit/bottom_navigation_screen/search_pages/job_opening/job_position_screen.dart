// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/insta_job_user/bottom_nav_screen/search_pages/search_jobs_screen.dart';
import 'package:insta_job/screens/insta_job_user/confirm_detail_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/add_job_position_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_opening_page.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_expantion_tile.dart';

import '../../../../../bloc/bottom_bloc/bottom_bloc.dart';
import '../../../../../utils/my_colors.dart';
import 'view_candidate.dart';

class JobPositionScreen extends StatefulWidget {
  final JobPosModel? jobPosModel;
  final CompanyModel? companyModel;
  const JobPositionScreen({Key? key, this.jobPosModel, this.companyModel})
      : super(key: key);

  @override
  State<JobPositionScreen> createState() => _JobPositionScreenState();
}

class _JobPositionScreenState extends State<JobPositionScreen> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Positioned(
              right: 0,
              top: 0,
              left: 0,
              child: Image.network(
                  "${EndPoint.imageBaseUrl}${widget.jobPosModel!.uploadPhoto}",
                  fit: BoxFit.cover)),
          Positioned(
            top: 0,
            child: BlocBuilder<BottomBloc, BottomInitialState>(
                builder: (context, value) {
              return ImageButton(
                onTap: () {
                  if (Global.userModel?.type == "user") {
                    context.read<BottomBloc>().add(
                        SetScreenEvent(true, screenName: SearchJobsScreen()));
                  } else {
                    context.read<BottomBloc>().add(SetScreenEvent(true,
                        screenName: JobOpeningScreen(
                            companyModel: widget.companyModel)));
                  }

                  AppRoutes.pushAndRemoveUntil(context, BottomNavScreen());
                },
                image: MyImages.backArrow,
                height: 40,
                width: 40,
              );
            }),
          ),
          Positioned(
            top: 0,
            right: 10,
            child: Global.userModel?.type == "user"
                ? IconButton(
                    icon: Icon(Icons.share, color: MyColors.white),
                    onPressed: () {},
                  )
                : SizedBox(),
          ),
          Positioned(
              left: 0,
              top: MediaQuery.of(context).size.height * 0.36,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: "${widget.jobPosModel?.designation}",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ImageButton(
                                          image: MyImages.bag,
                                          padding: EdgeInsets.zero),
                                      SizedBox(width: 5),
                                      CommonText(
                                        text: "Job Name",
                                        fontColor: MyColors.blue,
                                        fontSize: 15,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  CommonText(
                                    text: "Job Details",
                                    fontSize: 15,
                                  ),
                                  SizedBox(height: 15),
                                  CommonText(
                                    text: "${widget.jobPosModel?.jobdetails}",
                                    fontSize: 13,
                                    fontColor: MyColors.grey,
                                  ),
                                  SizedBox(height: 15),
                                  buildRequirementTile(widget.jobPosModel!),
                                  buildResponsibilityTile(widget.jobPosModel!),
                                  buildTopSkillsTile(widget.jobPosModel!),
                                  SizedBox(height: 15),
                                  BlocBuilder<BottomBloc, BottomInitialState>(
                                      builder: (context, value) {
                                    return Global.userModel?.type == "user"
                                        ? CustomButton(
                                            title: "Apply",
                                            onTap: () {
                                              AppRoutes.push(context,
                                                  ConfirmDetailsScreen());
                                            },
                                          )
                                        : Row(
                                            children: [
                                              Expanded(
                                                  child: CustomButton(
                                                title: "Edit Listing",
                                                onTap: () {
                                                  context
                                                      .read<BottomBloc>()
                                                      .add(SetScreenEvent(true,
                                                          screenName: AddJobPositionScreen(
                                                              jobPosModel: widget
                                                                  .jobPosModel,
                                                              companyModel: widget
                                                                  .companyModel,
                                                              isUpdate: true)));

                                                  AppRoutes.push(context,
                                                      BottomNavScreen());
                                                },
                                              )),
                                              SizedBox(width: 15),
                                              Expanded(
                                                  child: CustomButton(
                                                title: "View Candidates",
                                                onTap: () {
                                                  context
                                                      .read<BottomBloc>()
                                                      .add(SetScreenEvent(true,
                                                          screenName: ViewCandidates(
                                                              jobPosModel: widget
                                                                  .jobPosModel,
                                                              companyModel: widget
                                                                  .companyModel)));

                                                  AppRoutes.push(context,
                                                      BottomNavScreen());
                                                },
                                              )),
                                            ],
                                          );
                                  }),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              )),
          BlocBuilder<JobPositionBloc, JobPosState>(builder: (context, state) {
            return Positioned(
              top: MediaQuery.of(context).size.height * 0.334,
              right: 20,
              child: Global.userModel?.type == "user"
                  ? CustomCommonCard(
                      onTap: () {
                        isSaved = !isSaved;
                        setState(() {});
                        context.read<JobPositionBloc>().add(
                            SaveJobPositionEvent(
                                jobId: widget.jobPosModel!.id.toString()));
                      },
                      bgColor: MyColors.blue,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                            isSaved ? Icons.favorite : Icons.favorite_border,
                            color: MyColors.white),
                      ),
                    )
                  : SizedBox(),
            );
          }),
        ],
      ),
    ));
  }
}

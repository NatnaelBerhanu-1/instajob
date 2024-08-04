// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_bloc.dart';
import 'package:insta_job/bloc/check_kyc_availability/check_kyc_availability_bloc.dart';
import 'package:insta_job/bloc/check_kyc_availability/check_kyc_availability_state.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/auth_screen/change_account_info.dart';
import 'package:insta_job/screens/boading_screen/boarding_screen.dart';
import 'package:insta_job/screens/insta_job_user/bottom_nav_screen/search_pages/search_jobs_screen.dart';
import 'package:insta_job/screens/insta_job_user/bottom_nav_screen/user_account/save_jobs/save_jobs_screen.dart';
import 'package:insta_job/screens/insta_job_user/career_cluster_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/automate_messages/automate_message_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/setting_pages/setting_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/subscribe_pages/job_board_screen.dart';
import 'package:insta_job/screens/kyc/upload_kyc_screen.dart';
import 'package:insta_job/screens/resume_edit_screens/cv_template_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/guest_login_info.dart';
import 'package:insta_job/widgets/user_tile/custom_acc_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/global_cubit/global_state.dart';
import 'bottom_navigation_screen/user_account/feedback/feedback_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if(Global.userModel?.id != null) {
      debugPrint("LOGG init state of home page");
      String userId = (Global.userModel?.id  ?? "").toString();
      context.read<CheckKycAvailabilityCubit>().execute(userId: userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    var selectedIndex = context.watch<GlobalCubit>().sIndex;
    return WillPopScope(
      onWillPop: () async {
        context.read<BottomBloc>().add(GetIndexEvent(0));
        context
            .read<BottomBloc>()
            .add(SetScreenEvent(true, screenName: SearchJobsScreen()));
        return true;
      },
      child: Scaffold(
        body: Global.userModel?.id != null ? SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 15),
            child: BlocBuilder<GlobalCubit, InitialState>(
                builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    MyImages.user_4x,
                                    fit: BoxFit.cover,
                                    color: MyColors.user,
                                    // height: 100,
                                    width: 90,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        AppRoutes.push(
                                            context, ChangeAccInfoScreen());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: MyColors.blue,
                                            shape: BoxShape.circle),
                                        child: Image.asset(MyImages.edit,
                                            fit: BoxFit.cover,
                                            color: MyColors.white,
                                            // height: 100,
                                            width: 22),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 19),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: CommonText(
                                  text: Global.userModel?.type == "user"
                                      ? "${Global.userModel?.name?[0].toUpperCase()}${Global.userModel?.name?.substring(1)}"
                                      : "${Global.userModel?.companyName?[0].toUpperCase()}${Global.userModel?.companyName?.substring(1)}",
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800,
                                  fontColor: MyColors.blue,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Global.userModel?.uploadPhoto == null
                              ? SizedBox()
                              : Container(
                                  height: 150,
                                  color: MyColors.transparent,
                                  child: CachedNetworkImage(
                                    fadeInDuration:
                                        const Duration(milliseconds: 250),
                                    imageUrl:
                                        "${EndPoint.imageBaseUrl}${Global.userModel?.uploadPhoto}",
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    placeholder: (val, _) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                  )
                                  // Image.network(
                                  //   "${EndPoint.imageBaseUrl}${Global.userModel?.uploadPhoto}",
                                  //   fit: BoxFit.fitHeight,
                                  // ),
                                  ),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "Account Details",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontColor: MyColors.userFont,
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              Global.userModel?.type == "user"
                                  ? Expanded(
                                      child: CustomAccDetails(
                                        onTap: () async {
                                          // var pref =
                                          //     await SharedPreferences.getInstance();
                                          // var isGetStarted =
                                          //     pref.getBool("isGetStarted");
                                          // if (isGetStarted == true) {
                                          //   AppRoutes.push(
                                          //       context, CvTemplateScreen());
                                          // } else {
                                          //   context
                                          //       .read<GlobalCubit>()
                                          //       .changeIndex(0);
                                          //   AppRoutes.push(
                                          //       context, OnBoardingScreen());
                                          // }
                                        },
                                        index: 0,
                                        isLock: true,
                                        selectedIndex: selectedIndex,
                                        width: double.infinity,
                                        img: MyImages.automateMsg,
                                        title: "Edit Resume/Bio",
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(width: 15),
                              Expanded(
                                child: CustomAccDetails(
                                  onTap: () {
                                    context.read<GlobalCubit>().changeIndex(1);
                                    AppRoutes.push(context, FeedBackScreen());
                                  },
                                  index: 1,
                                  selectedIndex: selectedIndex,
                                  width: double.infinity,
                                  img: MyImages.rate,
                                  title: "Feedbacks",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              Global.userModel?.type == "user" ? Expanded(
                                child: CustomAccDetails(
                                  onTap: () {
                                    if (Global.userModel?.type == "user") {
                                      context
                                          .read<GlobalCubit>()
                                          .changeIndex(2);
                                      context
                                          .read<CareerLearningBloc>()
                                          .getCareerClusterList();
                                      AppRoutes.push(
                                          context, CareerClusterScreen());
                                    } else {
                                      // AppRoutes.push(
                                      //     context, JobBoardsScreen());
                                    }
                                  },
                                  index: 2,
                                  isLock: Global.userModel?.type == "user"
                                      ? false
                                      : true,
                                  selectedIndex: selectedIndex,
                                  width: double.infinity,
                                  img: Global.userModel?.type == "user"
                                      ? MyImages.mail
                                      : MyImages.subscribe,
                                  title: Global.userModel?.type == "user"
                                      ? "Career Learning"
                                      : "Subscribe",
                                ),
                              ) : SizedBox(), // TODO: Needs to be changed when subscription implemented
                              SizedBox(width: 15),
                              Expanded(
                                child:
                                    BlocBuilder<JobPositionBloc, JobPosState>(
                                        builder: (context, state) {
                                  return CustomAccDetails(
                                    onTap: () {
                                      context
                                          .read<GlobalCubit>()
                                          .changeIndex(3);
                                      if (Global.userModel?.type == "user") {
                                        context
                                            .read<JobPositionBloc>()
                                            .add(SavedJobPositionListEvent());
                                        // context
                                        //     .read<JobPositionBloc>()
                                        //     .add(AppliedJobListEvent());
                                        AppRoutes.push(
                                            context, SaveJobsScreen());
                                      } else {
                                        AppRoutes.push(
                                            context, AutomateMsgScreen());
                                      }
                                    },
                                    index: 3,
                                    selectedIndex: selectedIndex,
                                    width: double.infinity,
                                    img: Global.userModel?.type == "user"
                                        ? MyImages.suitcase
                                        : MyImages.automateMsg,
                                    title: Global.userModel?.type == "user"
                                        ? "Saved Jobs"
                                        : "Automate Message",
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              Expanded(
                                child: CustomAccDetails(
                                  onTap: () {
                                    context.read<GlobalCubit>().changeIndex(4);
                                    AppRoutes.push(context, SettingScreen());
                                  },
                                  index: 4,
                                  selectedIndex: selectedIndex,
                                  width: double.infinity,
                                  img: MyImages.settings,
                                  title: "Settings",
                                ),
                              ),
                              SizedBox(width: 15),
                              if (Global.userModel?.type == "user")
                                BlocBuilder<CheckKycAvailabilityCubit, 
                                CheckKycAvailabilityState>(
                                  builder: (context, state) {
                                    // if (state is CheckKycAvailabilityNotFound) { //meaning kyc not uploaded yet, hence show the button
                                    if (true) {
                                      return Expanded(
                                        child: CustomAccDetails(
                                          onTap: () {
                                            context.read<GlobalCubit>().changeIndex(5);
                                            AppRoutes.push(context, UploadKycScreen());                                    
                                          },
                                          index: 5,
                                          selectedIndex: selectedIndex,
                                          width: double.infinity,
                                          // img: MyImages.settings,
                                          img: MyImages.edit,
                                          // title: "Fill KYC Info",
                                          title: "Update banking info",
                                        ),
                                      );
                                    }
                                    return SizedBox.shrink();
                                  }
                                ),
                            ],
                          ),
                          SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ) : GuestLoginInfoWidget(),
      ),
    );
  }
}

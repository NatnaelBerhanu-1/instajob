// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_event.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/applicants_page.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../bloc/bottom_bloc/bottom_bloc.dart';
import '../utils/my_colors.dart';
import '../utils/my_images.dart';
import 'custom_button/custom_img_button.dart';
import 'custom_cards/custom_common_card.dart';

class CandidateTile extends StatelessWidget {
  final ValueChanged? onchange;
  final bool? value;
  final bool idDeny;
  final JobPosModel? appliedJobModel;
  const CandidateTile(
      {Key? key,
      this.onchange,
      this.value,
      this.appliedJobModel,
      this.idDeny = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tab = context.watch<GlobalCubit>();
    return BlocBuilder<BottomBloc, BottomInitialState>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () {
          context.read<BottomBloc>().add(SetScreenEvent(true,
              screenName: Applicants(jobPosModel: appliedJobModel)));
          context.read<ResumeBloc>().add(UserResumeLoadedEvent(
              userId: appliedJobModel?.userId.toString()));
          print("USER ID ${appliedJobModel?.userId}");
          AppRoutes.push(context, BottomNavScreen());
        },
        child: Container(
            decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MyColors.lightgrey),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.10),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(2, 3))
                ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 10, bottom: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 0,
                    child: idDeny
                        ? SizedBox(width: 12)
                        : Checkbox(
                            visualDensity: VisualDensity.comfortable,
                            fillColor: MaterialStateProperty.all(MyColors.blue),
                            onChanged: onchange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            value: value,
                            // activeColor: MyColors.green,
                            // checkColor: MyColors.white,
                            side: BorderSide(color: MyColors.blue, width: 2),
                          ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: CachedNetworkImageProvider(
                                  "${EndPoint.imageBaseUrl}${appliedJobModel?.uploadPhoto}"),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: "${appliedJobModel?.userName}",
                                  fontSize: 14,
                                  fontColor: MyColors.black,
                                  overflow: TextOverflow.clip,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(height: 5),
                                CommonText(
                                  text: "${appliedJobModel?.designation}",
                                  fontSize: 12,
                                  fontColor: MyColors.black,
                                  overflow: TextOverflow.clip,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        SizedBox(height: 10),
                        LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          width: 170.0,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 22.0,
                          backgroundColor: MyColors.lightBl,
                          percent: 0.87,
                          center: Text(
                            "90% Match",
                            style:
                                TextStyle(fontSize: 12, color: MyColors.blue),
                          ),
                          barRadius: Radius.circular(5),
                          progressColor: Colors.blue.shade100,
                        ),
                        /* Row(
                          children: [
                            CustomCommonCard(
                              bgColor: MyColors.lightBlue.withOpacity(.20),
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CommonText(
                                  text: "4 year Degree",
                                  fontSize: 12,
                                  fontColor: MyColors.blue,
                                  overflow: TextOverflow.clip,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            CustomCommonCard(
                              bgColor: Colors.purpleAccent.withOpacity(.30),
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CommonText(
                                  text: "6+ years",
                                  fontSize: 12,
                                  fontColor: Colors.purpleAccent,
                                  overflow: TextOverflow.clip,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )*/
                      ],
                    ),
                  ),
                  // Spacer(),
                  Expanded(
                    flex: 0,
                    child: ImageButton(
                      image: MyImages.rightArrow,
                      padding: EdgeInsets.zero,
                      height: 14,
                      width: 14,
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }
}

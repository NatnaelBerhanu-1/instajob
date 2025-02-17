// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/career_learning_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/screens/insta_job_user/bottom_nav_screen/user_account/occupation_details_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';

import '../../../../utils/my_images.dart';
import '../../../custom_button/custom_img_button.dart';
import '../../custom_common_card.dart';

class CustomCareerTile extends StatelessWidget {
  final ClusterDetailsModel? clusterDetailsModel;

  const CustomCareerTile({
    Key? key,
    this.clusterDetailsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GlobalCubit>().changeIndex(0);
        context
            .read<CareerLearningBloc>()
            .getDetailList(url: clusterDetailsModel!.href.toString());

        AppRoutes.push(context,
            OccupationDetailsScreen(clusterDetailsModel: clusterDetailsModel));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: MyColors.lightgrey),
              color: MyColors.white,
              boxShadow: [normalBoxShadow],
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: CustomCommonCard(
                        bgColor: MyColors.lightBlue.withOpacity(.25),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ImageButton(
                            image: MyImages.suitcase,
                            color: MyColors.blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "${clusterDetailsModel?.title}",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 7),
                          // CommonText(text: "Company Name", fontSize: 15),
                          Text.rich(
                            TextSpan(
                                text: "Code: ",
                                style: TextStyle(color: MyColors.grey),
                                children: [
                                  TextSpan(
                                    text: "${clusterDetailsModel?.code}",
                                    style: TextStyle(
                                        color: MyColors.black,
                                        fontWeight: FontWeight.w500),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 0),
                /* divider(), SizedBox(height: 5),
                CustomCommonCard(
                  bgColor: MyColors.grey.withOpacity(.30),
                  borderRadius: BorderRadius.circular(5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text.rich(
                      TextSpan(
                          text: "Occupation:  ",
                          style: TextStyle(color: MyColors.grey),
                          children: [
                            TextSpan(
                              text:
                                  "${clusterDetailsModel?.tags?.brightOutlook}",
                              style: TextStyle(
                                  color: MyColors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),
                  ),
                ),
                SizedBox(height: 5),*/
                // SizedBox(height: 10),
                // CommonText(
                //     text: "Civil Engineer",
                //     fontColor: MyColors.blue,
                //     fontSize: 13),
                // CommonText(text: "Company Name", fontSize: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppliedTile extends StatelessWidget {
  final JobPosModel? jobPosModel;
  final bool isFav;

  const AppliedTile({
    Key? key,
    this.isFav = false,
    this.jobPosModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.lightgrey),
          color: MyColors.white,
          boxShadow: [normalBoxShadow],
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCommonCard(
                    bgColor: MyColors.lightBlue.withOpacity(.25),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ImageButton(
                        image: MyImages.suitcase,
                        color: MyColors.blue,
                      ),
                    ),
                  ),
                  Spacer(),
                  !isFav
                      ? Icon(Icons.favorite, color: MyColors.darkRed)
                      : SizedBox(),
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              flex: 0,
              child: CommonText(
                  text: jobPosModel?.designation.toString(),
                  fontColor: MyColors.blue,
                  fontSize: 13),
            ),
            SizedBox(height: 5),
            /* Expanded(
                flex: 0,
                child:
                    CommonText(text: jobPosModel?.companyName, fontSize: 15)),
            SizedBox(height: 5),*/
            Expanded(
              flex: 0,
              child: CommonText(
                  text: jobPosModel?.jobDetails,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  fontColor: MyColors.greyTxt),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_position_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

class SearchJobTile extends StatelessWidget {
  final JobPosModel jobPosModel;
  final CompanyModel companyModel;

  const SearchJobTile(
      {Key? key, required this.jobPosModel, required this.companyModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.push(
            context,
            JobPositionScreen(
                jobPosModel: jobPosModel, companyModel: companyModel));
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
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            MyImages.suitcase,
                            height: 27,
                            width: 27,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: "${jobPosModel.designation}",
                                fontSize: 14,
                                fontColor: MyColors.black,
                                overflow: TextOverflow.clip,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                text: "S",
                                fontSize: 12,
                                fontColor: MyColors.grey,
                                overflow: TextOverflow.clip,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          CustomCommonCard(
                            bgColor: MyColors.lightBlue.withOpacity(.20),
                            borderRadius: BorderRadius.circular(5),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CommonText(
                                text: "${jobPosModel.jobsType}",
                                fontSize: 12,
                                fontColor: MyColors.blue,
                                overflow: TextOverflow.clip,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          CustomCommonCard(
                            bgColor: Colors.cyan.withOpacity(.20),
                            borderRadius: BorderRadius.circular(5),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CommonText(
                                text: "${jobPosModel.salaries}k",
                                fontSize: 12,
                                fontColor: Colors.cyan.shade600,
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
                                text:
                                    "${jobPosModel.experienceLevel == "Enter Level" ? "Entry Level" : jobPosModel.experienceLevel}",
                                fontSize: 12,
                                fontColor: Colors.purpleAccent,
                                overflow: TextOverflow.clip,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // Spacer(),
                Expanded(
                  flex: 0,
                  child: BlocBuilder<JobPositionBloc, JobPosState>(
                    builder: (context, state) {
                      // if (state is JobPosLoading) {
                      //   return Padding(
                      //     padding: const EdgeInsets.only(right: 10.0),
                      //     child: SizedBox(
                      //         width: 20,
                      //         height: 20,
                      //         child: CircularProgressIndicator(
                      //           strokeWidth: 2,
                      //         )),
                      //   );
                      // }
                      return IconButton(
                        onPressed: null,
                        // onPressed: () {
                        //   //TODO: implement
                        //   context
                        //       .read<JobPositionBloc>()
                        //       .add(SaveJobPositionEvent(
                        //         jobId: jobPosModel!.id.toString(),
                        //         jobStatus:
                        //             jobPosModel!.jobStatus == 1 ? "1" : "0",
                        //       ));
                        // },
                        icon: Icon(
                            jobPosModel.jobStatus == 1
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: jobPosModel.jobStatus == 1
                                ? MyColors.darkRed
                                : MyColors.grey),
                      );
                    },
                  ),
                ),

                // SizedBox(width: 15),
              ],
            ),
          )),
    );
  }
}

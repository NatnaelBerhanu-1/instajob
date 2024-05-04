// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_position_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../bloc/job_position/job_poision_bloc.dart';
import '../../bloc/job_position/job_pos_event.dart';
import '../../utils/my_colors.dart';
import '../custom_button/custom_img_button.dart';

class JobOpeningTile extends StatelessWidget {
  final JobPosModel jobPosModel;
  final CompanyModel? companyModel;
  final bool fromCompany;
  const JobOpeningTile(
      {Key? key,
      required this.jobPosModel,
      this.companyModel,
      this.fromCompany = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
      child: GestureDetector(
        onTap: () {
          context
              .read<JobPositionBloc>()
              .add(LoadJobPosListEvent(companyId: companyModel!.id.toString()));
          print(
              'JOBPOSITION ID ----------------- ********        *************         ${jobPosModel.id}');
          AppRoutes.push(
              context,
              JobPositionScreen(
                  jobPosModel: jobPosModel,
                  companyModel: companyModel,
                  fromCompany: fromCompany));
        },
        child: Container(
            decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MyColors.grey.withOpacity(.15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.10),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(2, 3))
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
              child: Row(
                children: [
                  ImageButton(
                    image: MyImages.suitcase,
                    height: 35,
                    width: 35,
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(width: 10),
                  CommonText(
                    text: "${jobPosModel.designation}",
                    fontSize: 14,
                    fontColor: MyColors.black,
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.w400,
                  ),
                  Spacer(),
                  Global.userModel?.type == "user"
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              jobPosModel.jobStatus == 1
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: jobPosModel.jobStatus == 1
                                  ? MyColors.darkRed
                                  : MyColors.grey,
                            ),
                          ))
                      : ImageButton(
                          padding: EdgeInsets.only(right: 0),
                          image: MyImages.rightArrow,
                          color: MyColors.blue,
                          height: 13,
                        ),
                  /*CustomCommonCard(
                        bgColor: MyColors.lightBlue,
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                               // ImageButton(
                               //    image: MyImages.safety,
                               //    padding: EdgeInsets.zero,
                               //    height: 14,
                               //    width: 14,
                               //  ),
                              if (snapshot is AppliedJobLoaded) ...[
                                CommonText(
                                    text:
                                        "${snapshot.appliedJobList.length + 1}",
                                    fontColor: MyColors.white,
                                    fontSize: 12),
                              ],
                              SizedBox(width: 5),
                              CommonText(
                                text: "applied",
                                fontSize: 12,
                                fontColor: MyColors.white,
                                overflow: TextOverflow.clip,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),*/
                ],
              ),
            )),
      ),
    );
  }
}

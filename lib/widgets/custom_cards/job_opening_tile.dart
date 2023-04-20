// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final bool? isFav;
  final JobPosModel jobPosModel;
  const JobOpeningTile({Key? key, this.isFav, required this.jobPosModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: () {
          context.read<JobPositionBloc>().add(LoadJobPosListEvent());
          print(
              'JOBPOSITION ID ----------------- ********        *************         ${jobPosModel.id}');
          AppRoutes.push(context, JobPositionScreen(jobPosModel: jobPosModel));
        },
        child: Container(
            decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MyColors.grey.withOpacity(.15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.10),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(2, 3))
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
              child: Row(
                children: [
                  ImageButton(
                    image: MyImages.suitcase,
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(width: 10),
                  CommonText(
                    text: "${jobPosModel.jobsType}",
                    fontSize: 14,
                    fontColor: MyColors.black,
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.w400,
                  ),
                  Spacer(),
                  isFav == true
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ImageButton(
                            image: MyImages.fav,
                            color: MyColors.grey,
                            padding: EdgeInsets.zero,
                            height: 20,
                            width: 20,
                          ),
                        )
                      : CustomCommonCard(
                          bgColor: MyColors.lightBlue,
                          borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                ImageButton(
                                  image: MyImages.safety,
                                  padding: EdgeInsets.zero,
                                  height: 14,
                                  width: 14,
                                ),
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
                        ),
                ],
              ),
            )),
      ),
    );
  }
}

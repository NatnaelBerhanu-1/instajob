// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/applicants_page.dart';
import 'package:insta_job/utils/app_routes.dart';

import '../bloc/bottom_bloc/bottom_bloc.dart';
import '../utils/my_colors.dart';
import '../utils/my_images.dart';
import 'custom_button/custom_img_button.dart';
import 'custom_cards/custom_common_card.dart';
import 'custom_chip.dart';

class DeniedCandidateTile extends StatelessWidget {
  const DeniedCandidateTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tab = context.watch<GlobalCubit>();
    return BlocBuilder<BottomBloc, BottomInitialState>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () {
          context
              .read<BottomBloc>()
              .add(SetScreenEvent(true, screenName: Applicants()));
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
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: "Candidate",
                                fontSize: 14,
                                fontColor: MyColors.black,
                                overflow: TextOverflow.clip,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                text: "2714 wasterrn ave.",
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
                      Row(
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
                      )
                    ],
                  ),
                  Spacer(),
                  ImageButton(
                    image: MyImages.rightArrow,
                    padding: EdgeInsets.zero,
                    height: 14,
                    width: 14,
                  ),
                ],
              ),
            )),
      );
    });
  }
}

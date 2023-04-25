// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/add_job_position_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/job_opening_tile.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../../bloc/bottom_bloc/bottom_bloc.dart';

class JobOpeningScreen extends StatelessWidget {
  const JobOpeningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 90),
          child: Padding(
            padding: const EdgeInsets.only(top: 42.0, bottom: 10),
            child: Row(
              // elevation: 0,
              // leadingWidth: 50,
              // backgroundColor: MyColors.white,
              // toolbarHeight: 70,
              // title:

              children: [
                ImageButton(
                  image: MyImages.backArrowBorder,
                  color: MyColors.blue,
                  height: 28,
                  width: 28,
                  padding: EdgeInsets.all(9.0),
                  onTap: () {
                    context.read<CompanyBloc>().add(LoadCompanyListEvent());
                    context.read<BottomBloc>().add(
                        SetScreenEvent(false, screenName: JobOpeningScreen()));
                    // context.read<BottomCubit>().setSelectedScreen(false,
                    //     screenName: JobOpeningScreen());
                  },
                ),
                Expanded(
                  child: IconTextField(
                    prefixIcon: ImageButton(
                      image: MyImages.searchGrey,
                      padding: EdgeInsets.all(14),
                      height: 10,
                      width: 10,
                    ),
                    borderRadius: 25,
                    hint: "search",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<BottomBloc>().add(SetScreenEvent(true,
                        screenName: AddJobPositionScreen()));
                    // AppRoutes.push(context, EditListing());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColors.blue, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Icon(
                          Icons.add,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Container(
              height: 180,
              alignment: Alignment.bottomLeft,
              width: double.infinity,
              decoration: BoxDecoration(
                  // color: MyColors.green,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(MyImages.staffMeeting),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Company Name",
                      fontColor: MyColors.white,
                      fontSize: 20,
                    ),
                    SizedBox(height: 10),
                    CommonText(
                      text:
                          "It's a long established fact that reader will directly by the",
                      fontColor: MyColors.white,
                      fontSize: 13,
                    ),
                    CommonText(
                      text:
                          "readable content of page when looking at it's layout",
                      fontColor: MyColors.white,
                      fontSize: 13,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<JobPositionBloc, JobPosState>(
                builder: (context, state) {
              if (state is JobPosLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ErrorState) {
                return Center(child: Text(state.error));
              }
              if (state is JobPosLoaded) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: ListView.builder(
                      itemCount: state.jobPosList.length,
                      itemBuilder: (c, i) {
                        var data = state.jobPosList[i];
                        return JobOpeningTile(jobPosModel: data);
                      }),
                );
              }
              return SizedBox();
            }),
          )
        ],
      ),
    );
  }
}

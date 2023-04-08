// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/edit_listing_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/job_opening_tile.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../../../bloc/global_cubit/global_cubit.dart';

class JobOpeningScreen extends StatelessWidget {
  const JobOpeningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 90),
            child: AppBar(
              elevation: 0,
              backgroundColor: MyColors.white,
              toolbarHeight: 70,
              title: IconTextField(
                prefixIcon: ImageButton(
                  image: MyImages.searchGrey,
                ),
                hint: "search",
              ),
              leading: ImageButton(
                image: MyImages.backArrowBorder,
                onTap: () {
                  context
                      .read<GlobalCubit>()
                      .setSelectedScreen(false, screenName: JobOpeningScreen());
                },
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<GlobalCubit>()
                        .setSelectedScreen(true, screenName: EditListing());
                    // AppRoutes.push(context, EditListing());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
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
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Column(
            children: [
              Container(
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
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (c, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        child: JobOpeningTile(),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}

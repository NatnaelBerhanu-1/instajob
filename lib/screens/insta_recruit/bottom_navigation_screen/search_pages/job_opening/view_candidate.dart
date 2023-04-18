// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_position_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/denied_candidate_tile.dart';

import '../../../../../model/job_position_model.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../utils/my_images.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button/custom_img_button.dart';
import '../../../../../widgets/custom_cards/notifications_tile/message_tile.dart';
import '../search_trash_screen.dart';

class ViewCandidates extends StatelessWidget {
  const ViewCandidates({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            leadingImage: MyImages.backArrow,
            onTap: () {
              AppRoutes.pop(context);
            },
            centerTitle: false,
            title: "Search",
            actions: Row(
              children: [
                ImageButton(
                  image: MyImages.searchBlue,
                ),
                ImageButton(
                  onTap: () {
                    AppRoutes.push(context, SearchTrash());
                  },
                  image: MyImages.delete,
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: MyColors.blue,
                        unselectedLabelColor: MyColors.tabClr,
                        tabs: [
                          Tab(text: "Applied"),
                          Tab(text: "Shortlisted"),
                          Tab(text: "Messages"),
                        ],
                      ),
                      Expanded(
                          child: TabBarView(children: [
                        buildDeniedCandidateTile(),
                        buildDeniedCandidateTile(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: MessageTile(),
                            );
                          },
                        ),
                      ]))
                    ],
                  )),
            )
            // ImageButton(image: ,)
          ],
        ));
  }
}

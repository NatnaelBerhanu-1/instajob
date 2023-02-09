// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/denied_candidate_tile.dart';

import '../../../../../utils/my_images.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button/custom_img_button.dart';
import '../../../../../widgets/custom_cards/notifications_tile/message_tile.dart';
import '../search_trash_screen.dart';

class ViewCandidates extends StatelessWidget {
  const ViewCandidates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            leadingImage: MyImages.backArrow,
            centerTitle: false,
            title: "Search",
            actions: Row(
              children: [
                ImageButton(
                  image: MyImages.searchBlue,
                ),
                ImageButton(
                  onTap: () {
                    push(context: context, screen: SearchTrash());
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
                        tabs: [
                          Tab(text: "Applied"),
                          Tab(text: "Shortlisted"),
                          Tab(text: "Message"),
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/widgets/candidate_tile.dart';

import '../../../../utils/my_colors.dart';
import '../../../../utils/my_images.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_button/custom_img_button.dart';
import '../../../../widgets/custom_cards/notifications_tile/message_tile.dart';

class SearchTrash extends StatefulWidget {
  const SearchTrash({Key? key}) : super(key: key);

  @override
  State<SearchTrash> createState() => _SearchTrashState();
}

class _SearchTrashState extends State<SearchTrash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            leadingImage: MyImages.backArrow,
            centerTitle: false,
            title: "Search Trash",
            actions: ImageButton(
              image: MyImages.searchBlue,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: MyColors.blue,
                        indicatorColor: MyColors.blue,
                        // onTap: (val) {
                        //   sTab = val;
                        //   setState(() {});
                        // },
                        tabs: [
                          Tab(text: "Denied"),
                          Tab(text: "Message"),
                        ],
                      ),
                      Expanded(
                          child: TabBarView(children: [
                        ListView.builder(
                            itemCount: 7,
                            itemBuilder: (c, i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: CandidateTile(),
                              );
                            }),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/widgets/custom_cards/job_opening_tile.dart';
import 'package:insta_job/widgets/custom_cards/notifications_tile/message_tile.dart';
import 'package:insta_job/widgets/denied_candidate_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(double.infinity, kToolbarHeight),
      //   child: CustomAppBar(
      //     title: "",
      //     leadingImage: MyImages.backArrow,
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MessageTile(),
                JobOpeningTile(),
                DeniedCandidateTile()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

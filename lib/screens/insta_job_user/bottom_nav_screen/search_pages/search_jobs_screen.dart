// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SearchJobsScreen extends StatelessWidget {
  const SearchJobsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          // GestureDetector(
          //     onTap: () {
          //       leaveSheet(context);
          //     },
          //     child: AppliedTile())
          // CustomCareerTile()
        ],
      ),
    ));
  }
}

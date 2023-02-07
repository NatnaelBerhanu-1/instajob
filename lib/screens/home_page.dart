// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_chip_container.dart';
import 'package:insta_job/widgets/user_tile/custom_acc_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigation(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(
                          MyImages.user_4x,
                          color: MyColors.blue.withOpacity(.20),
                          height: 100,
                          width: 100,
                        ),
                        CommonText(
                          text: "John Smith",
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          fontColor: MyColors.blue,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 120,
                      color: MyColors.grey,
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              CommonText(
                text: "Account Details",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: MyColors.grey,
              ),
              SizedBox(height: 25),
              CustomAccDetails(
                onTap: () {
                  selectedIndex = 1;
                  setState(() {});
                },
                index: 1,
                selectedIndex: selectedIndex,
                width: double.infinity,
                img: MyImages.rate,
                title: "Feedbacks",
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: CustomAccDetails(
                      onTap: () {
                        selectedIndex = 2;
                        setState(() {});
                      },
                      index: 2,
                      selectedIndex: selectedIndex,
                      width: double.infinity,
                      img: MyImages.subscribe,
                      title: "Subscribe",
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: CustomAccDetails(
                      onTap: () {
                        selectedIndex = 3;
                        setState(() {});
                      },
                      index: 3,
                      selectedIndex: selectedIndex,
                      width: double.infinity,
                      img: MyImages.automateMsg,
                      title: "Automate Message",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              CustomAccDetails(
                onTap: () {
                  selectedIndex = 4;
                  setState(() {});
                },
                index: 4,
                selectedIndex: selectedIndex,
                width: double.infinity,
                img: MyImages.settings,
                title: "Settings",
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

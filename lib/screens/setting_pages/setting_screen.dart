// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/setting_pages/aboutUs_screen.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/setting_tile.dart';

import '../../../utils/my_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button/custom_btn.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Settings",
              leadingImage: MyImages.arrowBlueLeft,
              height: 17,
              width: 17,
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SettingTile(
                onTap: () {
                  push(context: context, screen: AboutUsScreen());
                },
                leadingImage: MyImages.about,
                title: "About Us",
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {},
                leadingImage: MyImages.membership,
                title: "MemberShip Agreement",
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {},
                leadingImage: MyImages.user,
                title: "Change Account Information",
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {},
                leadingImage: MyImages.visaCardBlue,
                title: "Saved Cards",
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {},
                leadingImage: MyImages.cancelSub,
                title: "Cancel Subscription",
              ),
              Spacer(),
              CustomIconButton(
                image: MyImages.logout,
                title: "Log Out",
                backgroundColor: MyColors.red,
                fontColor: MyColors.white,
              ),
            ],
          ),
        ));
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/home_page.dart';
import 'package:insta_job/screens/resume_edit_screens/edit_template_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';

class CvTemplateScreen extends StatelessWidget {
  const CvTemplateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            title: "CV Template",
            onTap: () {
              context
                  .read<BottomBloc>()
                  .add(SetScreenEvent(true, screenName: HomePage()));
              AppRoutes.push(context, BottomNavScreen());
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            CustomButton(
              title: "Upload your Existing CV",
              bgColor: MyColors.white,
              borderColor: MyColors.blue,
              fontColor: MyColors.blue,
              onTap: () {
                // image.getCvImage();
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              title: "Edit Template",
              borderColor: MyColors.blue,
              onTap: () {
                AppRoutes.push(context, EditTemplateScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

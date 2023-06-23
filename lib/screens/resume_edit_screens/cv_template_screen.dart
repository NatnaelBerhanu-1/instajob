// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_event.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/home_page.dart';
import 'package:insta_job/screens/resume_edit_screens/edit_template_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:printing/printing.dart';

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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.64,
              child: PdfPreview(
                scrollViewDecoration: BoxDecoration(color: MyColors.white),
                onPageFormatChanged: (val) {
                  print('####### $val');
                },
                onError: (context, val) {
                  print('####### $val');
                  return CircularProgressIndicator();
                },
                pdfPreviewPageDecoration: BoxDecoration(
                    color: MyColors.white,
                    boxShadow: [
                      BoxShadow(
                          color: MyColors.lightgrey,
                          spreadRadius: 4,
                          blurRadius: 7)
                    ]),
                allowPrinting: false,
                canChangePageFormat: false,
                canChangeOrientation: false,
                allowSharing: false,
                dynamicLayout: false,
                // pdfFileName: "Resume",
                build: (c) => makePdf(context),
              ),
            ),
            SizedBox(height: 20),
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
                context.read<ResumeBloc>().add(UserResumeLoadedEvent());

                AppRoutes.push(context, EditTemplateScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

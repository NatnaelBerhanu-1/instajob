// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/dialog/applied_successful_dialog.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/insta_job_user/confirm_detail_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({Key? key}) : super(key: key);

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            actions: ImageButton(
              image: MyImages.download,
              color: MyColors.blue,
              onTap: () async {
                final pdfStorage = await getApplicationDocumentsDirectory();

                await FlutterDownloader.enqueue(
                  url: "${EndPoint.imageBaseUrl}${Global.userModel?.cv}",
                  headers: {}, // optional: header send with url (auth token etc)
                  savedDir: pdfStorage.path,
                  showNotification:
                      true, // show download progress in status bar (for Android)
                  openFileFromNotification:
                      true, // click on notification to open downloaded file (for Android)
                );
                // Global().openPdf(
                //     context,
                //     "${EndPoint.imageBaseUrl}${Global.userModel?.cv}",
                //     "${Global.userModel?.cv?.split('/').last}");
              },
            ),
            title: "Review Resume",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: MyColors.grey.withOpacity(.10),
                            spreadRadius: 5,
                            blurRadius: 8)
                      ]),
                  child: SfPdfViewer.network(
                    "${EndPoint.imageBaseUrl}${Global.userModel?.cv}",
                  ),
                ),
              ),
              SizedBox(height: 47),
              // Spacer(),
              Expanded(
                flex: 0,
                child: BlocConsumer<JobPositionBloc, JobPosState>(
                    listener: (context, state) {
                  if (state is JobErrorState) {
                    showToast(state.error);
                  }
                  if (state is JobAppliedSuccessState) {
                    buildDialog(context, AppliedSuccessDialog());
                  }
                }, builder: (context, state) {
                  return CustomButton(
                    title: "Apply Now",
                    onTap: () {
                      var applyData = context.read<JobPositionBloc>();
                      applyData.add(ApplyJobEvent(
                          Global.userModel!.cv.toString(),
                          jobId: applyData.jobModel.id.toString()));
                    },
                  );
                }),
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 0,
                child: CustomButton(
                  title: "Generate Cover Letter",
                  bgColor: MyColors.transparent,
                  borderColor: MyColors.blue,
                  fontColor: MyColors.blue,
                  onTap: () {
                    AppRoutes.push(context, ConfirmDetailsScreen());
                  },
                ),
              )
            ],
          ),
        ));
  }
}

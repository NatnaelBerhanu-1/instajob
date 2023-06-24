// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/dialog/applied_successful_dialog.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/cover_letter_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';

class CoverLetterScreen extends StatelessWidget {
  final CoverLetterModel coverLetterModel;
  const CoverLetterScreen({Key? key, required this.coverLetterModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            title: "Cover Letter",
            actions: IconButton(
                onPressed: () {
                  String text =
                      "Dear Hiring Manager,\nJob Title: ${context.read<JobPositionBloc>().jobModel.designation}\n${coverLetterModel.previousWork}\n${coverLetterModel.yourPassion}\nPlease take a moment to review my attached resume and credentials.\nSincerely\n${coverLetterModel.yourName}";
                  Clipboard.setData(ClipboardData(text: text)).then((value) {
                    showToast("Copied", isError: false);
                  });
                },
                icon: Icon(
                  Icons.copy,
                  color: MyColors.blue,
                )),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomCommonCard(
                borderColor: MyColors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Dear Hiring Manager,\n"),
                      Text(
                          "Job Title: ${context.read<JobPositionBloc>().jobModel.designation}\n"),
                      Text("${coverLetterModel.previousWork}\n"),
                      Text("${coverLetterModel.yourPassion}\n"),
                      Text(
                          "Please take a moment to review my attached resume and credentials.\n"),
                      Text("Thank you for your consideration\n"),
                      Text("Sincerely"),
                      Text("${coverLetterModel.yourName}"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                title: "Re-Generate",
                fontColor: MyColors.white,
                borderColor: MyColors.blue,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 30),
              BlocConsumer<JobPositionBloc, JobPosState>(
                  listener: (context, state) {
                if (state is JobErrorState) {
                  showToast(state.error);
                }
                if (state is JobAppliedSuccessState) {
                  buildDialog(
                      context, AppliedSuccessDialog(isCoverLetter: true));
                }
              }, builder: (context, state) {
                return CustomButton(
                  title: "Confirm & Apply",
                  onTap: () {
                    var applyData = context.read<JobPositionBloc>();
                    applyData.add(ApplyJobEvent(Global.userModel!.cv.toString(),
                        jobId: applyData.jobModel.id.toString()));
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

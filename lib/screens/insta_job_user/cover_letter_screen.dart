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
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';

class CoverLetterScreen extends StatefulWidget {
  final JobPosModel? jobPosModel;
  final CoverLetterModel coverLetterModel;

  const CoverLetterScreen(
      {Key? key, required this.coverLetterModel, this.jobPosModel})
      : super(key: key);

  @override
  State<CoverLetterScreen> createState() => _CoverLetterScreenState();
}

class _CoverLetterScreenState extends State<CoverLetterScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // controller.text =
    //     "Dear Hiring Manager,\nJob Title: ${widget.jobPosModel?.designation}\n${widget.coverLetterModel.previousWork}\n${widget.coverLetterModel.yourPassion}\nPlease take a moment to review my attached resume and credentials.\nSincerely\n${widget.coverLetterModel.yourName}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: MyColors.blue, width: 1.5));
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            title: "Cover Letter",
            // actions: IconButton(
            //     onPressed: () {
            //       String text =
            //           "Dear Hiring Manager,\nJob Title: ${widget.jobPosModel?.designation}\n${widget.coverLetterModel.previousWork}\n${widget.coverLetterModel.yourPassion}\nPlease take a moment to review my attached resume and credentials.\nSincerely\n${widget.coverLetterModel.yourName}";
            //       Clipboard.setData(ClipboardData(text: text)).then((value) {
            //         showToast("Copied", isError: false);
            //       });
            //     },
            //     icon: Icon(
            //       Icons.copy,
            //       color: MyColors.blue,
            //     )),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // TextField(
              //   controller: controller,
              //   maxLines: 10,
              // ),
              /*CustomCommonCard(
                borderColor: MyColors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Dear Hiring Manager,\n"),
                      Text("Job Title: ${widget.jobPosModel?.designation}\n"),
                      Text("${widget.coverLetterModel.previousWork}\n"),
                      Text("${widget.coverLetterModel.yourPassion}\n"),
                      Text(
                          "Please take a moment to review my attached resume and credentials.\n"),
                      Text("Thank you for your consideration\n"),
                      Text("Sincerely"),
                      Text("${widget.coverLetterModel.yourName}"),
                    ],
                  ),
                ),
              ),*/
              TextFormField(
                maxLines: 18,
                // controller: TextEditingController(
                //     text:
                //         "Dear Hiring Manager,\n\nJob Title: ${widget.jobPosModel?.designation}\n\n${widget.coverLetterModel.previousWork}\n\n${widget.coverLetterModel.yourPassion}\n\nPlease take a moment to review my attached resume and credentials.\n\nThank you for your consideration\n\nSincerely\n${widget.coverLetterModel.yourName}"),
                controller: controller,
                decoration: InputDecoration(
                  border: border,
                  focusedBorder: border,
                  enabledBorder: border,
                  disabledBorder: border,
                  // border: border,
                  // border: border,
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                title: "Copy Job Description",
                bgColor: MyColors.white,
                fontColor: MyColors.black,
                borderColor: MyColors.blue,
                onTap: () {
                  Clipboard.setData(ClipboardData(
                          text: widget.jobPosModel?.jobDetails ?? ""))
                      .then((value) {
                    showToast("Job description copied", isError: false);
                  });
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
                        jobId: widget.jobPosModel!.id.toString()));
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

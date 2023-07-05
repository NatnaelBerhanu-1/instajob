// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:intl/intl.dart';

import '../bloc/job_position/job_pos_event.dart';

class PickTimeDialog extends StatefulWidget {
  final JobPosModel? jobPosModel;

  const PickTimeDialog({Key? key, this.jobPosModel}) : super(key: key);

  @override
  State<PickTimeDialog> createState() => _PickTimeDialogState();
}

class _PickTimeDialogState extends State<PickTimeDialog> {
  TimeOfDay timeOfDay = TimeOfDay.now();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var selectedIndex = context.watch<GlobalCubit>().sIndex;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            CommonText(
              text: "Choose Time For",
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            CommonText(
              text: "Interview",
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                pickTime();
              },
              child: Container(
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                    border: Border.all(color: MyColors.lightBlue, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.call, color: MyColors.lightBlue),
                    // Spacer(),
                    SizedBox(width: 15),
                    CommonText(
                      text: formatTime ??
                          "${timeOfDay.hour.toString().padLeft(2, '0')} : ${timeOfDay.minute.toString().padLeft(2, '0')}",
                    ),
                    CommonText(
                      text: " | ",
                      fontColor: MyColors.lightGrey,
                      fontSize: 19,
                    ),
                    CommonText(
                      text: timeOfDay.period.name.toUpperCase(),
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 35),
            BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCommonCard(
                    onTap: () {
                      print('INDEX1 ------  $selectedIndex');
                      context.read<GlobalCubit>().changeIndex(1);
                      Navigator.pop(context);
                    },
                    bgColor:
                        selectedIndex == 1 ? MyColors.blue : MyColors.white,
                    borderColor: MyColors.blue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 30),
                      child: CommonText(
                        text: "Cancel",
                        fontColor: selectedIndex == 1
                            ? MyColors.white
                            : MyColors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  BlocBuilder<JobPositionBloc, JobPosState>(
                      builder: (context, state) {
                    return CustomCommonCard(
                      onTap: () {
                        print('INDEX2 ------  $selectedIndex');
                        context.read<GlobalCubit>().changeIndex(2);
                        if (formatTime != null) {
                          context.read<JobPositionBloc>().add(SetInterviewEvent(
                                time: formatTime,
                                timeType: timeOfDay.period.name.toUpperCase(),
                                employeeId: Global.userModel?.id.toString(),
                                companyId: "${widget.jobPosModel?.companyId}",
                                jobId: widget.jobPosModel?.id.toString(),
                                userId: widget.jobPosModel?.userId.toString(),
                              ));
                        } else {
                          showToast("Please choose time");
                        }
                        // Navigator.pop(context);
                      },
                      bgColor:
                          selectedIndex == 2 ? MyColors.blue : MyColors.white,
                      borderColor: MyColors.blue,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 30),
                        child: CommonText(
                          text: "Submit",
                          fontColor: selectedIndex == 2
                              ? MyColors.white
                              : MyColors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }),
                ],
              );
            }),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String? formatTime;
  pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: timeOfDay,
    );
    if (time != null) {
      timeOfDay = time;
      setState(() {});
    }
    var date =
        DateFormat("hh:mm").parse("${timeOfDay.hour}:${timeOfDay.minute}");
    var dateFormat = DateFormat("hh:mm");
    formatTime = dateFormat.format(date);
    print(formatTime);
  }
}

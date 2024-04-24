import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:intl/intl.dart';

import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';

class BookSlotScreen extends StatefulWidget {
  final JobPosModel? jobPosModel;
  const BookSlotScreen({super.key, required this.jobPosModel});

  @override
  State<BookSlotScreen> createState() => _BookSlotScreenState();
}

class _BookSlotScreenState extends State<BookSlotScreen> {
  DateTime selectedDate = DateTime.now();
  TimeSlot? selectedTimeSlot;

  void _pickDate() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2101, 12, 31),
        currentTime: selectedDate, onConfirm: (date) {
      DateTime selectedDateAtMidnight = DateTime(date.year, date.month, date.day, 0, 0);

      setState(() {
        // Update the selectedDate with the new date at midnight
        selectedDate = selectedDateAtMidnight;
      });
    });
  }

  List<TimeSlot> _generateTimeSlots(DateTime startTime, DateTime endTime) {
    List<TimeSlot> slots = [];
    DateTime currentDateTime = selectedDate;

    DateTime counterRunningTime = startTime;

    if (counterRunningTime.isAfter(endTime)) {
      return [];
    }

    while ((counterRunningTime.isBefore(endTime) || counterRunningTime.isAtSameMomentAs(endTime))) {
      if (isSameDateAsToday(currentDateTime) && counterRunningTime.isBefore(currentDateTime)) {
        counterRunningTime = counterRunningTime.add(const Duration(minutes: 10));
        continue;
      }
      var slotItem = TimeSlot(time: counterRunningTime);
      slots.add(
        slotItem,
      );
      counterRunningTime = counterRunningTime.add(const Duration(minutes: 10));
    }

    return slots;
  }

  @override
  Widget build(BuildContext context) {
    DateTime morningStartTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 6, 0);
    DateTime morningEndTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 11, 50);
    DateTime afternoonStartTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 12, 0);
    DateTime afternoonEndTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 21, 50);

    final dateFormat = DateFormat('EEEE, dd MMMM yyyy');

    List<TimeSlot> morningSlots = _generateTimeSlots(morningStartTime, morningEndTime);

    List<TimeSlot> afternoonSlots = _generateTimeSlots(afternoonStartTime, afternoonEndTime);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: CustomAppBar(
          backgroundColor: MyColors.blue,
          useLeadingImage: false,
          onTap: () {
            Navigator.of(context).pop();
          },
          centerTitle: false,
          title: "Book Slots",
          color: MyColors.white,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 8, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                        onPressed: isSameDateAsToday(selectedDate)
                            ? null
                            : () {
                                setState(() {
                                  selectedDate = selectedDate.subtract(const Duration(days: 1));
                                });
                              },
                        splashRadius: 30,
                      ),
                      GestureDetector(
                        onTap: _pickDate,
                        child: Text(
                          dateFormat.format(selectedDate),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedDate = selectedDate.add(const Duration(days: 1));
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // Morning Slots Section
                _buildSlotSection(slotTitle: "Morning", slots: morningSlots),

                const SizedBox(height: 20),
                // Afternoon Slots Section
                _buildSlotSection(slotTitle: "Afternoon", slots: afternoonSlots),
                // _buildAfternoonSlotSection(afternoonSlots),
                const SizedBox(height: 60),
              ],
            ),
          ),
          selectedTimeSlot != null
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildSlotSection({
    required String slotTitle,
    required List<TimeSlot> slots,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            slotTitle,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.04,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: slots.isEmpty
                  ? const Text("No data")
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // Number of columns
                        // crossAxisSpacing: 0.0,
                        // mainAxisSpacing: 0.0,
                        childAspectRatio:
                            2.2, // Adjust this value to control the aspect ratio (width/height) of each grid item
                      ),
                      itemCount: slots.length,
                      itemBuilder: (context, index) {
                        var item = slots[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTimeSlot = item;
                            });
                          },
                          child: TimeSlotChip(
                            isSelected: selectedTimeSlot == item,
                            timeSlot: item,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return CustomButton(
      width: 200,
      height: 40,
      onTap: selectedTimeSlot != null
          ? () {
              var date = DateFormat("hh:mm").parse("${selectedTimeSlot!.time.hour}:${selectedTimeSlot!.time.minute}");
              var dateFormat = DateFormat("hh:mm");
              String? formatTime = dateFormat.format(date);
              TimeOfDay timeOfDay = TimeOfDay.now();
              var setupInterviewEvent = SetInterviewEvent(
                time: formatTime,
                timeType: timeOfDay.period.name.toUpperCase(),
                employeeId: Global.userModel?.id.toString(),
                companyId: "${widget.jobPosModel?.companyId}",
                jobId: widget.jobPosModel?.jobId.toString(),
                userId: widget.jobPosModel?.userId.toString(),
              );
              debugPrint('InterviewEvent: ${setupInterviewEvent.toJson()}');
              context.read<JobPositionBloc>().add(setupInterviewEvent);
              Navigator.of(context).pop();
            }
          : null,
      title: "Set Interview Slot",
    );
  }
}

class TimeSlot extends Equatable {
  final DateTime time;

  const TimeSlot({required this.time});

  @override
  List<Object?> get props => [time];
}

class TimeSlotChip extends StatelessWidget {
  final TimeSlot timeSlot;
  final bool isSelected;
  const TimeSlotChip({
    Key? key,
    required this.timeSlot,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? MyColors.white : MyColors.black.withOpacity(0.5);
    final backgroundColor = isSelected ? MyColors.blue : null;

    DateTime currentTime = timeSlot.time;
    DateFormat timeFormat = DateFormat('h:mm a');

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(6)),
      child: Text(
        timeFormat.format(currentTime),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: textColor,
        ),
      ),
    );
  }
}

bool isSameDateAsToday(DateTime date) {
  // Get today's date
  DateTime today = DateTime.now();

  // Compare the year, month, and day of the given date with today's date
  return date.year == today.year && date.month == today.month && date.day == today.day;
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:intl/intl.dart';

import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';

class BookSlotScreen extends StatefulWidget {
  const BookSlotScreen({super.key});

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
      DateTime selectedDateAtMidnight =
          DateTime(date.year, date.month, date.day, 0, 0);

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

    while ((counterRunningTime.isBefore(endTime) ||
        counterRunningTime.isAtSameMomentAs(endTime))) {
      if (isSameDateAsToday(currentDateTime) &&
          counterRunningTime.isBefore(currentDateTime)) {
        counterRunningTime =
            counterRunningTime.add(const Duration(minutes: 10));
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
    DateTime morningStartTime =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 6, 0);
    DateTime morningEndTime = DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day, 11, 50);
    DateTime afternoonStartTime = DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day, 12, 0);
    DateTime afternoonEndTime = DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day, 21, 50);

    final dateFormat = DateFormat('EEEE, dd MMMM yyyy');

    List<TimeSlot> morningSlots =
        _generateTimeSlots(morningStartTime, morningEndTime);

    List<TimeSlot> afternoonSlots =
        _generateTimeSlots(afternoonStartTime, afternoonEndTime);

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionButton(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                            selectedDate =
                                selectedDate.subtract(const Duration(days: 1));
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: slots.isEmpty
                  ? const Text("No data")
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(MyColors.blue),
        foregroundColor: MaterialStateProperty.all(MyColors.white),
      ),
      onPressed: selectedTimeSlot != null ? () {} : null,
      child: const Text(
        "Set Interview Slot",
      ),
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
    final textColor =
        isSelected ? MyColors.white : MyColors.black.withOpacity(0.5);
    final backgroundColor = isSelected ? MyColors.blue : null;

    DateTime currentTime = timeSlot.time;
    DateFormat timeFormat = DateFormat('h:mm a');

    return Padding(
      padding: const EdgeInsets.all(4).copyWith(bottom: 0),
      child: Container(
        padding: const EdgeInsets.all(4).copyWith(top: 2),
        color: backgroundColor,
        child: Text(
          timeFormat.format(currentTime),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

bool isSameDateAsToday(DateTime date) {
  // Get today's date
  DateTime today = DateTime.now();

  // Compare the year, month, and day of the given date with today's date
  return date.year == today.year &&
      date.month == today.month &&
      date.day == today.day;
}

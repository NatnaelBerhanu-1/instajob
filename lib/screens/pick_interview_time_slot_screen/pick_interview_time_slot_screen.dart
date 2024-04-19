import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class BookSlotScreen extends StatefulWidget {
  const BookSlotScreen({super.key});

  @override
  State<BookSlotScreen> createState() => _BookSlotScreenState();
}

class _BookSlotScreenState extends State<BookSlotScreen> {
  DateTime selectedDate = DateTime.now();

  void _pickDate() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        // minTime: DateTime(2000, 1, 1),
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

  List<Widget> _generateTimeSlots(DateTime startTime, DateTime endTime) {
    List<Widget> slots = [];
    DateTime currentDateTime = selectedDate;

    DateTime counterRunningTime = startTime;

    if (counterRunningTime.isAfter(endTime)) {
      return [];
    }

    while ((counterRunningTime.isBefore(endTime) ||
        counterRunningTime.isAtSameMomentAs(endTime))) {
      if (isSameDateAsToday(currentDateTime) &&
          counterRunningTime.isBefore(currentDateTime)) {
        counterRunningTime = counterRunningTime.add(Duration(minutes: 10));
        continue;
      }
      String timeSuffix = currentDateTime.hour < 12 ? 'am' : 'pm';
      slots.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ActionChip(
            label: Text(
                "${counterRunningTime.hour}:${counterRunningTime.minute.toString().padLeft(2, '0')} $timeSuffix"),
            onPressed: () {
              // Handle time slot selection here
              print(
                  "Selected time slot: ${counterRunningTime.hour}:${counterRunningTime.minute}");
            },
          ),
        ),
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

    List<Widget> morningSlots =
        _generateTimeSlots(morningStartTime, morningEndTime);

    List<Widget> afternoonSlots =
        _generateTimeSlots(afternoonStartTime, afternoonEndTime);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: CustomAppBar(
          leadingImage: MyImages.backArrow,
          onTap: () {
            Navigator.of(context).pop();
          },
          centerTitle: false,
          title: "Book Slots",
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              // color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
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
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      setState(() {
                        selectedDate =
                            selectedDate.add(const Duration(days: 1));
                      });
                    },
                  ),
                ],
              ),
            ),

            // Morning Slots Section
            _buildMorningSlotSection(morningSlots),

            const SizedBox(height: 20),
            // Afternoon Slots Section
            _buildAfternoonSlotSection(afternoonSlots),
          ],
        ),
      ),
    );
  }

  Padding _buildAfternoonSlotSection(List<Widget> afternoonSlots) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Afternoon',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            // child: Wrap(
            //   children:
            //       _generateTimeSlots(morningStartTime, morningEndTime),
            // ),
            child: afternoonSlots.isEmpty
                ? Text("No data")
                : GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // Number of columns
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 0.0,
                    ),
                    itemCount: afternoonSlots.length,
                    itemBuilder: (context, index) {
                      return afternoonSlots[index];
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Padding _buildMorningSlotSection(List<Widget> morningSlots) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Morning',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: morningSlots.isEmpty
                ? const Text("No data")
                : GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // Number of columns
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 0.0,
                    ),
                    itemCount: morningSlots.length,
                    itemBuilder: (context, index) {
                      return morningSlots[index];
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class TimeSlotChip extends StatelessWidget {
  final String timeText;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotChip({
    super.key,
    required this.timeText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueAccent : Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey,
              width: 1.0,
            ),
          ),
          child: Text(
            timeText,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
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

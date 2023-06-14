// import 'package:flutter/material.dart';
// import 'package:insta_job/bloc/validation/validation_bloc.dart';
// import 'package:insta_job/globals.dart';
// import 'package:insta_job/screens/insta_job_user/SliderScreen/tellus_about_yslf_page.dart';
// import 'package:insta_job/screens/insta_job_user/SliderScreen/work_experience_screen.dart';
//
// class PageViewDemo extends StatefulWidget {
//   const PageViewDemo({Key? key}) : super(key: key);
//
//   @override
//   State<PageViewDemo> createState() => _PageViewDemoState();
// }
//
// class _PageViewDemoState extends State<PageViewDemo> {
//   // declare and initizlize the page controller
//   final PageController _pageController = PageController(initialPage: 0);
//
//   // the index of the current page
//   int _activePage = 0;
//
//   final List<Widget> subPage = [
//     const EducationScreen(),
//     const EducationScreen(isWork: true),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final List _pages = [
//       const TellUsAboutYSlfPage(),
//       subPage,
//       Container(),
//     ];
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             onPageChanged: (int page) {
//               setState(() {
//                 _activePage = page;
//               });
//             },
//             itemCount: _pages.length,
//             itemBuilder: (BuildContext context, int index) {
//               return _pages[index % _pages.length];
//             },
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             height: 100,
//             child: Container(
//               color: Colors.black54,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List<Widget>.generate(
//                     _pages.length,
//                     (index) => Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: InkWell(
//                             onTap: () {
//                               _pageController.animateToPage(index,
//                                   duration: const Duration(milliseconds: 300),
//                                   curve: Curves.easeIn);
//                             },
//                             child: CircleAvatar(
//                               radius: 8,
//                               backgroundColor: _activePage == index
//                                   ? Colors.amber
//                             : Colors.grey,
//                             ),
//                           ),
//                         )),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Test extends StatelessWidget {
//   Test({Key? key}) : super(key: key);
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               controller: TextEditingController(),
//               // validator: (val) =>
//               //     AppValidation.requiredValidation(val.toString(), ""),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                   } else {
//                     showToast("message");
//                   }
//                 },
//                 child: Text("child"))
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

/*import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/occupation_details_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _dateTime = DateTime.now();
  var dropdownValue;

  @override
  Widget build(BuildContext context) {
    print('DATETIME ----------  ${_dateTime}');
    return Scaffold(
        appBar: AppBar(
          title: Text("Time"),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              hourMinute12H(date: _dateTime),
              */ /*DropdownButtonHideUnderline(
                child: DropdownButton(
                  items: joinUser == 1
                      ? []
                      : controller.getCompanyList.isEmpty
                          ? ['No company Found']
                              .map((e) => DropdownMenuItem(child: Text('$e')))
                              .toList()
                          : List
                              .map((items) => DropdownMenuItem(
                                    value: "$_dateTime",
                                    child: Text(items.name.toString()),
                                  ))
                              .toList(),
                  onChanged: (newVal) {
                    setState(() {
                      dropdownValue = newVal;
                      print("$dropdownValue");
                    });
                  },
                  value: dropdownValue,
                  hint: Text(
                    "Select Company",
                    style: TextStyle(color: MyColors.black, fontSize: 16),
                  ),
                  style: TextStyle(
                    color: MyColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                  dropdownColor: MyColors.white,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: MyColors.grey,
                  ),
                ),
              ),*/

import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class TimePickerDropDown extends StatefulWidget {
  final Function(DateTime)? onTimeSelected;

  TimePickerDropDown({this.onTimeSelected});

  @override
  _TimePickerDropDownState createState() => _TimePickerDropDownState();
}

class _TimePickerDropDownState extends State<TimePickerDropDown> {
  late List<int> hoursList;
  late List<int> minutesList;
  late List<String> time;
  int? selectedHour;
  int? selectedMinute;
  @override
  void initState() {
    super.initState();
    hoursList = List.generate(12, (index) => index + 1);
    minutesList = List.generate(60, (index) => index);
    time = List.generate(2, (index) => index.toString());
    selectedHour = DateTime.now().hour;
    selectedMinute = DateTime.now().minute;
  }

  TimeOfDay timeOfDay = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              /*DropdownButton<int>(
                // value: selectedHour,
                onChanged: (value) {
                  setState(() {
                    selectedHour = value!;
                    widget.onTimeSelected!(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        selectedHour!,
                        selectedMinute!));
                  });
                },
                items: hoursList.map((int hour) {
                  return DropdownMenuItem<int>(
                    value: hour,
                    child: Text(hour.toString().padLeft(2, '0')),
                  );
                }).toList(),
              ),
              SizedBox(width: 8),
              Text(':'),
              SizedBox(width: 8),
              Center(
                child: DropdownButton<int>(
                  // value: selectedMinute,
                  onChanged: (value) {
                    setState(() {
                      selectedMinute = value!;
                      widget.onTimeSelected!(DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          selectedHour!,
                          selectedMinute!));
                    });
                  },
                  items: minutesList.map((int minute) {
                    return DropdownMenuItem<int>(
                      value: minute,
                      child: Text(minute.toString().padLeft(2, '0')),
                    );
                  }).toList(),
                ),
              ),*/
              Container(
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                    border: Border.all(color: MyColors.lightBlue, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Icon(Icons.call, color: MyColors.lightBlue),
                    DropdownButton<int>(
                      // value: selectedHour,
                      onChanged: (value) {
                        setState(() {
                          selectedHour = value!;
                          widget.onTimeSelected!(DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              selectedHour!,
                              selectedMinute!));
                        });
                      },
                      items: hoursList.map((int hour) {
                        return DropdownMenuItem<int>(
                          value: hour,
                          child: Text(hour.toString().padLeft(2, '0')),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text("${timeOfDay.hour}:${timeOfDay.minute}"),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    // pickTime();
                  },
                  child: Text("SHOW TIME")),
              // Material(
              //   elevation: 3,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: 5,
              //     itemBuilder: (c, i) {
              //       return Text("data");
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

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
    print("WWWWW $timeOfDay");
    DateTime tempDate =
        DateFormat("hh:mm").parse("${timeOfDay.hour}:${timeOfDay.minute}");
    var dateFormat = DateFormat("h:mm a"); // you can change the format here
    print(dateFormat.format(tempDate));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int progress = 0;

  final ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort?.send([id, status, progress]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$progress",
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(
              height: 60,
            ),
            TextButton(
              child: Text("Start Downloading"),
              onPressed: () async {
                // Global().openPdf(
                //     context,
                //     "https://shaybani-web.ondemandservicesappinflutter.online/storage/files/64522e9faa054.pdf",
                //     "ABC");
                // FileStorage.writeCounter(
                //     "https://shaybani-web.ondemandservicesappinflutter.online/storage/files/64522e9faa054.pdf",
                //     "geeksforgeeks.txt");
                // final status = await Permission.storage.request();
                //
                // if (status.isGranted) {
                final externalDir = await getExternalStorageDirectory();
                //
                await FlutterDownloader.enqueue(
                  url:
                      "https://shaybani-web.ondemandservicesappinaflutter.online/storage/files/64522e9faa054.pdf",
                  savedDir: externalDir!.path,
                  fileName: "download",
                  showNotification: true,
                  openFileFromNotification: true,
                );
                // } else {
                //   print("Permission deined");
                // }
              },
            )
          ],
        ),
      ),
    );
  }
}

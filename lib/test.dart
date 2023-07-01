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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

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
              */

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:video_player/video_player.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  CameraController? _cameraController;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _cameraController.dispose();
  //   super.dispose();
  // }

  _initCamera() async {
    print("############################################");
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController?.initialize();
    print("********************************");

    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController?.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(path: file!.path),
      );
      Navigator.push(context, route);
      print("PATH  ${file!.path}");
    } else {
      await _cameraController?.initialize();
      await _cameraController?.prepareForVideoRecording();
      await _cameraController?.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(_cameraController!),
            Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                backgroundColor: MyColors.blue,
                child: Icon(_isRecording ? Icons.stop : Icons.circle),
                onPressed: () => _recordVideo(),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class VideoPage extends StatefulWidget {
  final String path;
  const VideoPage({Key? key, required this.path}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? videoPlayerController;
  initVideo() async {
    videoPlayerController = VideoPlayerController.file(File(widget.path));
    await videoPlayerController?.initialize();
    await videoPlayerController?.setLooping(true);
    await videoPlayerController?.play();
  }

  @override
  void initState() {
    // initVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: initVideo(),
              builder: (c, state) {
                if (state.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  VideoPlayer(videoPlayerController!);
                }
                return Text("data");
              })),
    );
  }

  // @override
  // void dispose() {
  //   videoPlayerController?.dispose();
  //   super.dispose();
  // }
}

class VideoCall extends StatelessWidget {
  const VideoCall({Key? key}) : super(key: key);
  sendMail() async {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: [
        "khushali1.saurabhinfosys@gmail.com",
        "abc@gmail.com",
      ],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
    print("^^^^^^^^^^ $email");
    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendMail();
        },
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

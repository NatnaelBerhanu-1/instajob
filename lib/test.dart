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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/resume_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'utils/my_images.dart';
import 'widgets/custom_button/custom_img_button.dart';

class CreatePdfScreen extends StatefulWidget {
  const CreatePdfScreen({Key? key}) : super(key: key);

  @override
  State<CreatePdfScreen> createState() => _CreatePdfScreenState();
}

class _CreatePdfScreenState extends State<CreatePdfScreen> {
  Future<Uint8List> makePdf() {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(build: (context) {
      return pw.Row(
        children: [
          pw.Expanded(
              child: pw.Container(
            width: 230,
            decoration: pw.BoxDecoration(
                // color: PdfColor.fromHex("#0FBCFD"),
                ),
            child: pw.Stack(children: [
              pw.Column(
                children: [
                  pw.Container(
                      // constraints: pw.BoxConstraints(maxHeight: double.infinity),
                      height: 725,
                      width: 210,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromHex("#CAFFC8"),
                      ),
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(15),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.only(top: 40, left: 14),
                              // top: 30,
                              // left: ,
                              child: pw.Container(
                                height: 150,
                                width: 150,
                                // alignment: pw.Alignment.center,
                                decoration: pw.BoxDecoration(
                                    color: PdfColor.fromHex("#0FBCFD"),
                                    shape: pw.BoxShape.circle),
                              ),
                            ),
                            pw.SizedBox(height: 30),
                            pw.Text("Name",
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.Text("Designation",
                                style: pw.TextStyle(fontSize: 17)),
                            pw.SizedBox(height: 30),
                            pw.Text("ABOUT ME",
                                style: pw.TextStyle(
                                    fontSize: 17,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.Divider(),
                            pw.Text("fdngnnnnnnnnnnnnnnnnnn eune erjeimalkf ",
                                style: pw.TextStyle(fontSize: 15)),
                          ],
                        ),
                      )),
                ],
              ),
            ]),
          )),
          pw.SizedBox(width: 10),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 20),
                pw.Text("WORK EXPERIENCE",
                    style: pw.TextStyle(
                        fontSize: 17, fontWeight: pw.FontWeight.bold)),
                pw.Divider(),
                pw.Text("fdngnnnnnnnnkkkkkkkkkkkknnnnnnnnnn eune erjeimalkf ",
                    style: pw.TextStyle(fontSize: 15)),
                pw.SizedBox(height: 50),
                pw.Text("EDUCATION",
                    style: pw.TextStyle(
                        fontSize: 17, fontWeight: pw.FontWeight.bold)),
                pw.Divider(),
                pw.Text("fdngnnnnnnnnkkkkkkkkkkkknnnnnnnnnn eune erjeimalkf ",
                    style: pw.TextStyle(fontSize: 15)),
              ],
            ),
          )
        ],
      );
    }));
    /* pdf.editPage(0, pw.Page(build: (context) {
      return pw.Row();
    }));*/
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        allowPrinting: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        allowSharing: false,
        dynamicLayout: false,
        // pdfFileName: "Resume",
        build: (context) => makePdf(),
      ),
    );
  }
}

class Test extends StatelessWidget {
  final VoidCallback? onTap;
  final Educations? educations;
  final WorkExperiences? workExperiences;
  final bool isWorkExp;
  final int index;

  const Test(
      {Key? key,
      this.onTap,
      this.educations,
      this.workExperiences,
      this.isWorkExp = false,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCommonCard(
      borderRadius: BorderRadius.circular(10),
      borderColor: MyColors.lightgrey,
      boxShadow: normalBoxShadow,
      bgColor: MyColors.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(9),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: MyColors.blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9), topRight: Radius.circular(9)),
            ),
            child: Row(
              children: [
                Text(
                  "${isWorkExp ? "Work Experience" : "Education"} $index",
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                BlocBuilder<ResumeBloc, ResumeState>(
                    builder: (context, snapshot) {
                  return ImageButton(
                    image: MyImages.cancel2x,
                    padding: EdgeInsets.zero,
                    height: 19,
                    color: MyColors.white,
                    onTap: onTap,
                    // onTap: () {
                    //   data.add(DeleteEducation(index));
                    // },
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                          text: isWorkExp ? "Job Title:" : "Institute Name:",
                          fontSize: 14),
                      CommonText(
                          text: isWorkExp ? "Employee:" : "Field Of Study:",
                          fontSize: 14),
                      CommonText(text: "City:", fontSize: 14),
                      CommonText(text: "State:", fontSize: 14),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                          text: isWorkExp
                              ? "${workExperiences?.jobTitle}"
                              : "${educations?.institutionName}",
                          fontSize: 14),
                      CommonText(
                          text: isWorkExp
                              ? "${workExperiences?.employer}"
                              : "${educations?.fieldOfStudy}",
                          fontSize: 14),
                      CommonText(
                          text: isWorkExp
                              ? "${workExperiences?.workCity}"
                              : "${educations?.educationCity}",
                          fontSize: 14),
                      CommonText(
                          text: isWorkExp
                              ? "${workExperiences?.workState}"
                              : "${educations?.educationState}",
                          fontSize: 14),
                      // CommonText(
                      //     text:
                      //         "${educations?.educationStartMonth} - ${educations?.educationStartYear}",
                      //     fontSize: 14),
                      // CommonText(
                      //     text:
                      //         "${educations?.educationEndMonth} - ${educations?.educationEndYear}",
                      //     fontSize: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

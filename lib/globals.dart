// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/resume_edit_screens/edit_template_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'model/user_model.dart';
import 'utils/my_images.dart';
import 'widgets/custom_button/custom_img_button.dart';

class Global {
  // static String? type;
  static UserModel? userModel;

  Future<File?> downloadPdf(context, String url, String fileName) async {
    final pdfStorage = await getApplicationDocumentsDirectory();
    var pdf = File("${pdfStorage.path}/$fileName");
    try {
      loading(value: true);
      final response = await Dio().get(url,
          onReceiveProgress: (count, total) {},
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            // headers: {
            //   "Authorization": Global.userModel?.token,
            //   "Accept": "application/json",
            //   "Access-Control_Allow_Origin": "*"
            // },
          ));
      loading(value: false);
      final exe = pdf.openSync(mode: FileMode.write);
      exe.writeFromSync(response.data);
      await exe.close();
      return pdf;
    } on DioException catch (e) {
      loading(value: false);
      print("@@@ Error ${e.type}");
      showToast("Something went wrong");
      return null;
    }
  }

  Future<List<String>?> downloadMultiplePdfsNew(
      List<String> resumeUrlsList) async {
    try {
      // List to store paths of downloaded files
      List<String> downloadedFilePaths = [];

      for (var i = 0; i < resumeUrlsList.length; i++) {
        var currUrl = resumeUrlsList[i];
        // Get the temporary directory
        final tempDir = await getTemporaryDirectory();
        // Define the path for the temporary file
        final tempFilePath =
            '${tempDir.path}/resume${Random().nextInt(10000) + 1}.pdf';

        // Download the file and save it to the temporary file path
        final response = await Dio()
            .download("${EndPoint.imageBaseUrl}$currUrl", tempFilePath);

        if (response.statusCode == 200) {
          // Attach the downloaded file to the email
          downloadedFilePaths.add(tempFilePath);
        } else if (response.statusCode == 500) {
          print('Failed to download resume: HTTP ${response.statusCode}');
          throw Exception();
        } else {
          print('Failed to download resume: HTTP ${response.statusCode}');
        }
      }
      return downloadedFilePaths;
    } on DioException catch (e) {
      print("@@@ Error ${e.type}");
      showToast("Something went wrong");
      return null;
    }
  }

  Future<List<String>?> maskMultipleResumesAndDownloadthem(
      List<String> resumeUrlsList) async {
    try {
      List<String> downloadedMaskedFilePaths = [];

      for (var i = 0; i < resumeUrlsList.length; i++) {
        var currUrl = resumeUrlsList[i];
        // Get the temporary directory
        final tempDir = await getTemporaryDirectory();
        // Define the path for the temporary file
        final tempFilePath =
            '${tempDir.path}/masked_resume${Random().nextInt(10000) + 1}.pdf';

        //first mask the pdf and get downloadable link from endpoint
        FormData formData = FormData.fromMap({
          'resume': await MultipartFile.fromFile(currUrl),
          'api_key': "86wbdiu23hu134jsdf", // TODO: move to ENV later
        });

        final response =
            await Dio().post(EndPoint.maskResumeNewFull, data: formData);

        if (response.statusCode == 200) {
          String maskedUrlRes = response.data["masked_resume_url"];
          final response2 = await Dio().download(maskedUrlRes,
              tempFilePath); //using the response url got from mask api

          if (response2.statusCode == 200) {
            downloadedMaskedFilePaths.add(tempFilePath);
          } else if (response2.statusCode == 500) {
            print('Failed to download resume: HTTP ${response.statusCode}');
            throw Exception();
          } else {
            print('Failed to download resume: HTTP ${response.statusCode}');
            throw Exception();
          }
        } else if (response.statusCode == 500) {
          print('Failed to download resume: HTTP ${response.statusCode}');
          throw Exception();
        } else {
          print('Failed to download resume: HTTP ${response.statusCode}');
          throw Exception();
        }
      }
      return downloadedMaskedFilePaths;
    } on DioException catch (e) {
      print("@@@ Error ${e.type}");
      showToast("Something went wrong");
      return null;
    }
  }

  Future<List<int>?> getResumesMatchingScore(
      List<String> resumeUrlsList) async {
    // unimplemented //TODO:(URGENT)
    try {
      List<int> scores = []; //score out of 100

      for (var i = 0; i < resumeUrlsList.length; i++) {
        var currUrl = resumeUrlsList[i];

        FormData formData = FormData.fromMap({
          'resume': await MultipartFile.fromFile(currUrl),
          'api_key': "86wbdiu23hu134jsdf", // TODO: move to ENV later
        });

        final response =
            await Dio().post(EndPoint.resumeMatcherNewFull, data: formData);

        if (response.statusCode == 200) {
          int scoreRes = response.data["score"]; //untested TODO: CHECK
          scores.add(scoreRes);
        } else if (response.statusCode == 500) {
          print('Failed to get score: HTTP ${response.statusCode}');
          throw Exception();
        } else {
          print('Failed to get score: HTTP ${response.statusCode}');
          throw Exception();
        }
      }
      return scores;
    } on DioException catch (e) {
      print("@@@ Error ${e.type}");
      showToast("Something went wrong");
      return null;
    }
  }

  openPdf(BuildContext context, String url, String fileName) async {
    final file = await downloadPdf(context, url, fileName.split('/').last);
    if (file == null) return;

    print("Path : ${file.path}");
    await OpenFileSafePlus.open(file.path);
  }
}

List<Color> colors = [
  Color(0xDDB2E3FF),
  Color(0xe5aba7ff),
  // Color(0x56b7b0ff),
  // Colors.
  Colors.teal.shade200,
];

Widget verifyImage = ImageButton(
  image: MyImages.verified,
  padding: const EdgeInsets.all(14),
  height: 10,
  width: 10,
);

Future selectDate(BuildContext context, DateTime date) async {
// DateFormat('dd-MM-yyyy').format(date);
  DateTime current = DateTime.now();
  DateTime? pickedDate = await showDatePicker(
      context: context,
      builder: (context, child) {
        return child!;
      },
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 30),
      initialDate: date,
      currentDate: DateTime.now());
  if (pickedDate != null) {
    return pickedDate;
  } else {
    print("ERROR");
    return current;
  }
}

BoxShadow boxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.10),
  offset: const Offset(3, 3),
  spreadRadius: 5,
  blurRadius: 7,
);

BoxShadow blueBoxShadow = BoxShadow(
  color: MyColors.lightBlue.withOpacity(0.10),
  offset: const Offset(0, 5),
  spreadRadius: 5,
  blurRadius: 10,
);
BoxShadow normalBoxShadow = BoxShadow(
  color: MyColors.lightgrey,
  offset: const Offset(0, 4),
  spreadRadius: 2,
  blurRadius: 7,
);

Future<Uint8List> makePdf(BuildContext context, {int? color, font, String? image}) async {
  final pdf = pw.Document();
  var data = context.read<ResumeBloc>();
  final netImage = await networkImage(image ?? profileImage);

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
                      color: PdfColor.fromInt(color ?? 0xffEEF3F1),
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
                                color: PdfColor.fromHex("#b9ccc8"),
                                shape: pw.BoxShape.circle,
                                image: pw.DecorationImage(image: netImage, fit: pw.BoxFit.cover),
                              ),
                              // child: image == null
                              //     ? pw.SizedBox()
                              //     : pw.Image(netImage)
                            ),
                          ),
                          pw.SizedBox(height: 30),
                          pw.Text("${Global.userModel?.name}",
                              style: pw.TextStyle(fontSize: 20, font: font, fontWeight: pw.FontWeight.bold)),
                          pw.Text("Designation", style: pw.TextStyle(fontSize: 17, font: font)),
                          pw.SizedBox(height: 30),
                          pw.Text("ABOUT ME",
                              style: pw.TextStyle(fontSize: 17, font: font, fontWeight: pw.FontWeight.bold)),
                          pw.Divider(),
                          pw.Text(
                              data.resumeModel.tellUss == null
                                  ? "nfdskgndkjgoir mfkngjknrtgsk edfjo"
                                  : "${data.resumeModel.tellUss?[0].tellUs}",
                              style: pw.TextStyle(fontSize: 15, font: font)),
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
              pw.Text("WORK EXPERIENCE", style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold, font: font)),
              pw.Divider(),
              pw.SizedBox(height: 20),
              data.resumeModel.workExperiences == null
                  ? pw.Text("Test", style: pw.TextStyle(fontSize: 15, font: font))
                  : pw.ListView.builder(
                      itemCount: data.resumeModel.workExperiences!.length,
                      itemBuilder: (c, i) {
                        return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                          pw.Text("${data.resumeModel.workExperiences?[i].jobTitle}",
                              style: pw.TextStyle(fontSize: 15, font: font, fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 5),
                              pw.Row(children: [
                            pw.Text("${data.resumeModel.workExperiences?[i].employer}",
                                style: pw.TextStyle(fontSize: 15, font: font)),
                                pw.Spacer(),
                                pw.Text(
                                    "${data.resumeModel.workExperiences?[i].workStartYear} - ${data.resumeModel.workExperiences?[i].workEndYear == "" ? "Currently Working" : data.resumeModel.workExperiences?[i].workEndYear}",
                                style: pw.TextStyle(fontSize: 11, font: font)),
                              ]),
                              pw.SizedBox(height: 20),
                            ]);
                      },
                    ),
              pw.SizedBox(height: 50),
              pw.Text("EDUCATION", style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold, font: font)),
              pw.Divider(),
              pw.SizedBox(height: 20),
              data.resumeModel.educations == null
                  ? pw.Text("Test", style: pw.TextStyle(fontSize: 15, font: font))
                  : pw.ListView.builder(
                      itemCount: data.resumeModel.educations!.length,
                      itemBuilder: (c, i) {
                        return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                          pw.Text("${data.resumeModel.educations?[i].fieldOfStudy}",
                              style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, font: font)),
                              pw.SizedBox(height: 2),
                              pw.Row(children: [
                            pw.Text("${data.resumeModel.educations?[i].institutionName}",
                                style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, font: font)),
                                pw.Spacer(),
                                pw.Text(
                                    "${data.resumeModel.educations?[i].educationStartYear} - ${data.resumeModel.educations?[i].educationEndYear == "" ? "Currently Studying" : data.resumeModel.educations?[i].educationEndYear}",
                                style: pw.TextStyle(fontSize: 12, font: font)),
                              ]),
                              pw.SizedBox(height: 25),
                            ]);
                      },
                    ),
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

showToast(message, {color, textColor, bool isError = true}) {
  EasyLoading.instance
    ..toastPosition = EasyLoadingToastPosition.top
    ..textColor = textColor ?? MyColors.white
    ..backgroundColor = isError ? MyColors.darkRed : MyColors.black;
  EasyLoading.showToast(message);
}

dynamic loading({@required bool? value, String? title, bool closeOverlays = false}) {
  if (value!) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..backgroundColor = MyColors.white
      ..maskColor = MyColors.grey.withOpacity(.2)

      /// custom style
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = MyColors.blue
      ..textColor = MyColors.black

      ///
      ..userInteractions = false
      ..animationStyle = EasyLoadingAnimationStyle.offset;
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      status: "Loading..",
      dismissOnTap: true,
    );
  } else {
    EasyLoading.dismiss();
  }
}

final navigationKey = GlobalKey<NavigatorState>();

List<String> fontName = [
  "Courier",
  "Helvetica",
  "Open sans",
];
List<pw.Font> fontStyle = [
  pw.Font.courier(),
  pw.Font.helvetica(),
  pw.Font.times(),
];

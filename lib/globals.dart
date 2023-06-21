// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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

  openPdf(BuildContext context, String url, String fileName) async {
    final file = await downloadPdf(context, url, fileName.split('/').last);
    if (file == null) return;

    print("Path : ${file.path}");
    await OpenFile.open(file.path);
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
                      color: PdfColor.fromHex("#eef3f1"),
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

showToast(message, {color, textColor, bool isError = false}) {
  EasyLoading.instance
    ..toastPosition = EasyLoadingToastPosition.top
    ..textColor = textColor ?? MyColors.white
    ..backgroundColor = isError ? MyColors.lightRed : MyColors.black;
  EasyLoading.showToast(message);
}

dynamic loading(
    {@required bool? value, String? title, bool closeOverlays = false}) {
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

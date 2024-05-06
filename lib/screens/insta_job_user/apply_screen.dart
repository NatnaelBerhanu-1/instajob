// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/dialog/applied_successful_dialog.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/insta_job_user/confirm_detail_screen.dart';
import 'package:insta_job/screens/insta_job_user/cover_letter_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ApplyScreen extends StatefulWidget {
  final JobPosModel? jobPosModel;
  final CompanyModel? companyModel;
  const ApplyScreen({Key? key, this.jobPosModel, this.companyModel}) : super(key: key);

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final ReceivePort _port = ReceivePort();
  // void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  //   final SendPort? send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port');
  //   send?.send([id, status, progress]);
  // }

  Future<void> loadPdfFromUrl() async {
    //Load an image from website/webspace
    var url = "${EndPoint.imageBaseUrl}${Global.userModel?.cv}";
    var response = await http.get(Uri.parse(url));
    var data = response.bodyBytes;
    //Create a new PDF document
    PdfDocument document = PdfDocument(inputBytes: data);
    // print('###### $data');
    //Save and launch the document
    final List<int> bytes = await document.save();

    //Dispose the document.
    final PdfPage page = document.pages[0];
    page.graphics.drawString('Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)), bounds: const Rect.fromLTWH(0, 0, 150, 20));
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/dummy.pdf');
    file.writeAsBytes(bytes);
    await document.save();
    document.dispose();
    // Opent he fine.
    // OpenFile.open('$path/Flutter_Succinctly.pdf');
  }

  edit() async {
    final PdfDocument document = PdfDocument(inputBytes: File("input.pdf").readAsBytesSync());
    final PdfPage page = document.pages[0];
    page.graphics.drawString('Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)), bounds: const Rect.fromLTWH(0, 0, 150, 20));
    File('output.pdf').writeAsBytes(await document.save());
    document.dispose();
  }

  @override
  void initState() {
    super.initState();

    // IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = DownloadTaskStatus(data[1]);
    //   int progress = data[2];
    //   print("QQQWWWW-->  $data");
    //   setState((){ });
    // });

    // FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    // IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            actions: ImageButton(
              image: MyImages.download,
              color: MyColors.blue,
              onTap: () async {
                // final pdfStorage = await getExternalStorageDirectory();
                // File file = File("${pdfStorage?.path}/edited_pdf.pdf");
                // var exist = await file.exists();
                // print('EXIST ==>  $exist');
                // print('PATH ==>  ${pdfStorage?.path}');
                // final PdfDocument document=PdfDocument(inputBytes: File("").readAsBytesSync());
                edit();
                // loadPdfFromUrl();
                // print("${EndPoint.imageBaseUrl}${Global.userModel?.cv}");
                /*await FlutterDownloader.enqueue(
                  url: "${EndPoint.imageBaseUrl}${Global.userModel?.cv}",
                  headers: {}, // optional: header send with url (auth token etc)
                  savedDir: pdfStorage.path,
                  saveInPublicStorage: true,
                  showNotification:
                      true, // show download progress in status bar (for Android)
                  openFileFromNotification:
                      true, // click on notification to open downloaded file (for Android)
                );*/
                // Global().openPdf(
                //     context,
                //     "${EndPoint.imageBaseUrl}${Global.userModel?.cv}",
                //     "${Global.userModel?.cv?.split('/').last}");
              },
            ),
            title: "Review Resume",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: MyColors.grey.withOpacity(.10), spreadRadius: 5, blurRadius: 8)]),
                  child: SfPdfViewer.network(
                    "${EndPoint.imageBaseUrl}${Global.userModel?.cv}",
                  ),
                ),
              ),
              SizedBox(height: 47),
              // Spacer(),
              Expanded(
                flex: 0,
                child: BlocConsumer<JobPositionBloc, JobPosState>(listener: (context, state) {
                  if (state is JobErrorState) {
                    showToast(state.error);
                    // buildDialog(context, AppliedSuccessDialog(companyModel: widget.companyModel));
                  }
                  if (state is JobAppliedSuccessState) {
                    buildDialog(context, AppliedSuccessDialog(companyModel: widget.companyModel));
                  }
                }, builder: (context, state) {
                  return CustomButton(
                    loading: state is JobPosLoading,
                    title: "Apply Now",
                    onTap: () {
                      var applyData = context.read<JobPositionBloc>();
                      applyData.add(
                          ApplyJobEvent(Global.userModel!.cv.toString(), jobId: widget.jobPosModel!.id.toString()));
                    },
                  );
                }),
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 0,
                child: CustomButton(
                  title: "Generate Cover Letter",
                  bgColor: MyColors.transparent,
                  borderColor: MyColors.blue,
                  fontColor: MyColors.blue,
                  onTap: () {
                    // AppRoutes.push(context,
                    //     ConfirmDetailsScreen(jobPosModel: widget.jobPosModel));
                    AppRoutes.push(context, CoverLetterScreen(coverLetterModel: null, jobPosModel: widget.jobPosModel, companyModel: widget.companyModel));
                  },
                ),
              )
            ],
          ),
        ));
  }
}

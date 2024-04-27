import 'package:flutter/material.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewingScreen extends StatelessWidget {
  final String? cvUrl;
  const PdfViewingScreen({super.key, required this.cvUrl});

  @override
  Widget build(BuildContext context) {
    debugPrint("cvUrl ${EndPoint.imageBaseUrl}/$cvUrl");
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Text("HI"),
            Expanded(
              flex: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 13.0, left: 5),
                          child: ImageButton(
                            onTap: () {
                              AppRoutes.pop(context);
                            },
                            image: MyImages.backArrow,
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Image.asset(
                          MyImages.bgCurve,
                          color: MyColors.grey.withOpacity(.10),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(MyImages.instaLogo_),
                                CommonText(
                                  text: "Employ instantly",
                                  fontColor: MyColors.grey,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (cvUrl != null)
              const Column(
                children: [
                  CommonText(
                    text: "Your Resume",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            if (cvUrl != null)
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: MyColors.grey.withOpacity(.10), spreadRadius: 5, blurRadius: 8)]),
                    child: SfPdfViewer.network(
                      "${EndPoint.imageBaseUrl}$cvUrl",
                    ),
                  ),
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

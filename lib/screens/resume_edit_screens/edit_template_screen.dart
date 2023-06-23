// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/insta_job_user/SliderScreen/Slider_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/custom_template_card.dart';
import 'package:printing/printing.dart';

class EditTemplateScreen extends StatefulWidget {
  const EditTemplateScreen({Key? key}) : super(key: key);

  @override
  State<EditTemplateScreen> createState() => _EditTemplateScreenState();
}

class _EditTemplateScreenState extends State<EditTemplateScreen> {
  int index = 0;
  int? fontIndex;
  int color = 0xffEEF3F1;
  var pdfFont;
  String profileImage = "https://www.nfet.net/nfet.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            title: "",
            actions: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: MyColors.blue)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Text(
                    "Preview",
                    style: TextStyle(fontSize: 13, color: MyColors.blue),
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          )),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView(
          // physics: ClampingScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.62,
              child: PdfPreview(
                scrollViewDecoration: BoxDecoration(color: MyColors.white),
                onPageFormatChanged: (val) {
                  print('####### $val');
                },
                onError: (context, val) {
                  print('####### $val');
                  return CircularProgressIndicator();
                },
                pdfPreviewPageDecoration: BoxDecoration(
                    color: MyColors.white,
                    boxShadow: [
                      BoxShadow(
                          color: MyColors.lightgrey,
                          spreadRadius: 1,
                          blurRadius: 10)
                    ]),
                allowPrinting: false,
                canChangePageFormat: false,
                canChangeOrientation: false,
                allowSharing: false,
                dynamicLayout: false,
                // pdfFileName: "Resume",
                build: (c) => makePdf(context,
                    color: color, font: pdfFont, image: profileImage),
              ),
            ),
            SizedBox(height: 20),
            if (index == 1)
              ...[]
            else if (index == 2) ...[
              Container(
                decoration: BoxDecoration(color: MyColors.white, boxShadow: [
                  BoxShadow(
                    color: MyColors.lightgrey,
                    offset: const Offset(0, -3),
                    spreadRadius: 5,
                    blurRadius: 10,
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                index = 0;
                                setState(() {});
                              },
                              icon: Icon(Icons.arrow_back_sharp,
                                  color: MyColors.blue)),
                          CommonText(text: "Color"),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(colors.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                color = colors[index].value;
                                setState(() {});
                                print('COLOR=====>  $color');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: colors[index],
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ] else if (index == 3) ...[
              Container(
                decoration: BoxDecoration(color: MyColors.white, boxShadow: [
                  BoxShadow(
                    color: MyColors.lightgrey,
                    offset: const Offset(0, -3),
                    spreadRadius: 5,
                    blurRadius: 10,
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                index = 0;
                                setState(() {});
                              },
                              icon: Icon(Icons.arrow_back_sharp,
                                  color: MyColors.blue)),
                          CommonText(text: "Fonts"),
                        ],
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: fontName.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (c, i) {
                            return GestureDetector(
                              onTap: () {
                                fontIndex = i;
                                pdfFont = fontStyle[i];
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height: 70,
                                  // width: 70,
                                  // alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: MyColors.white,
                                      border: Border.all(
                                          color: fontIndex == i
                                              ? MyColors.blue
                                              : MyColors.lightGrey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: fontIndex == i
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0, top: 10),
                                        child: fontIndex == i
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Image.asset(
                                                    MyImages.verified,
                                                    height: 12,
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                      ),
                                      CommonText(
                                        text: "Aa",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CommonText(
                                        text: fontName[i],
                                        fontSize: 11,
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              )
            ] else if (index == 4) ...[
              Container(
                decoration: BoxDecoration(color: MyColors.white, boxShadow: [
                  BoxShadow(
                    color: MyColors.lightgrey,
                    offset: const Offset(0, -3),
                    spreadRadius: 5,
                    blurRadius: 10,
                  )
                ]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              index = 0;
                              setState(() {});
                            },
                            icon: Icon(Icons.arrow_back_sharp,
                                color: MyColors.blue)),
                        CommonText(text: "Change Photo"),
                      ],
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: CustomButton(
                        title: "Take a Photo",
                        bgColor: MyColors.white,
                        borderColor: MyColors.blue,
                        fontColor: MyColors.blue,
                        onTap: () async {
                          var imageBloc = context.read<PickImageCubit>();
                          imageBloc.isCamera = true;
                          await imageBloc.getImage();
                          profileImage =
                              "${EndPoint.imageBaseUrl}${imageBloc.imgUrl}";
                          setState(() {});
                          print("+++++++++++ $profileImage");
                          // image.getCvImage();
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: CustomButton(
                        title: "Upload From Gallery",
                        borderColor: MyColors.blue,
                        onTap: () async {
                          var imageBloc = context.read<PickImageCubit>();
                          imageBloc.isCamera = false;
                          await imageBloc.getImage();
                          profileImage =
                              "${EndPoint.imageBaseUrl}${imageBloc.imgUrl}";
                          setState(() {});
                          print("+++++++++++ $profileImage");
                          // AppRoutes.push(context, EditTemplateScreen());
                        },
                      ),
                    ),
                  ],
                ),
              )
            ] else ...[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: CustomTemplateCard(
                          label: "Change",
                          label2: "Templates",
                          onTap: () {
                            // index = 1;
                            setState(() {});
                          },
                        )),
                        // Spacer(),
                        SizedBox(width: 20),
                        Expanded(
                            child: CustomTemplateCard(
                          label: "Change",
                          label2: "Colors",
                          onTap: () {
                            index = 2;
                            setState(() {});
                          },
                        )),
                        // Spacer(),
                        SizedBox(width: 20),
                        Expanded(
                            child: CustomTemplateCard(
                          label: "Change",
                          label2: "Fonts",
                          onTap: () {
                            index = 3;
                            setState(() {});
                          },
                        )),
                        // Spacer(),
                        SizedBox(width: 20),
                        Expanded(
                            child: CustomTemplateCard(
                          label: "Change",
                          label2: "Photo",
                          onTap: () {
                            index = 4;
                            setState(() {});
                          },
                        )),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CustomButton(
                        title: "Edit Content",
                        bgColor: MyColors.white,
                        borderColor: MyColors.blue,
                        fontColor: MyColors.blue,
                        onTap: () {
                          AppRoutes.push(context, SliderScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      )),
    );
  }
}

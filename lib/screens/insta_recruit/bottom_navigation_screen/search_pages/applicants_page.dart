// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/view_candidate.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/applicant_tile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../bloc/bottom_bloc/bottom_bloc.dart';

class Applicants extends StatefulWidget {
  const Applicants({Key? key}) : super(key: key);

  @override
  State<Applicants> createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  @override
  Widget build(BuildContext context) {
    var tab = context.watch<GlobalCubit>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppBar(
          imageColor: MyColors.blue,
          centerTitle: false,
          leadingImage: MyImages.backArrowBorder,
          height: 30,
          width: 30,
          title: "Applicants",
          onTap: () {
            // context
            //     .read<BottomCubit>()
            //     .setSelectedScreen(true, screenName: ViewCandidates());
            context
                .read<BottomBloc>()
                .add(SetScreenEvent(true, screenName: ViewCandidates()));
            tab.changeTabValue(0);
            AppRoutes.push(context, BottomNavScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinearPercentIndicator(
                    width: 170.0,
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 25.0,
                    backgroundColor: MyColors.lightBl,
                    percent: 0.87,
                    center: Text(
                      "90% Match",
                      style: TextStyle(fontSize: 12, color: MyColors.blue),
                    ),
                    barRadius: Radius.circular(5),
                    progressColor: Colors.blue.shade100,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: MyColors.grey.withOpacity(.10),
                              spreadRadius: 5,
                              blurRadius: 8)
                        ]),
                    child: SfPdfViewer.network(
                      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 15),
              Expanded(
                flex: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                        height: MediaQuery.of(context).size.height * 0.055,
                        title: "Contact",
                      )),
                      tab.selectedTab == 1 ? SizedBox() : SizedBox(width: 15),
                      tab.selectedTab == 1
                          ? SizedBox()
                          : Expanded(
                              child: CustomButton(
                              height:
                                  MediaQuery.of(context).size.height * 0.055,
                              title: "Shortlisted",
                              bgColor: MyColors.cyan,
                            )),
                      tab.selectedTab == 4 ? SizedBox() : SizedBox(width: 15),
                      tab.selectedTab == 4
                          ? SizedBox()
                          : Expanded(
                              child: CustomButton(
                              height:
                                  MediaQuery.of(context).size.height * 0.055,
                              bgColor: MyColors.lightRed,
                              title: "Deny",
                            )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: DefaultTabController(
                    length: 6,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: MyColors.blue,
                          isScrollable: true,
                          unselectedLabelColor: MyColors.tabClr,
                          indicatorColor: MyColors.blue,
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 4),
                          tabs: [
                            Tab(text: "Skills"),
                            Tab(text: "Accomplishments"),
                            Tab(text: "Education"),
                            Tab(text: "Experience"),
                            Tab(text: "Bio"),
                            Tab(text: "Reviews"),
                          ],
                        ),
                        Expanded(
                            child: TabBarView(children: [
                          ApplicantTiles(),
                          ApplicantTiles(),
                          ApplicantTiles(),
                          ApplicantTiles(),
                          ApplicantTiles(),
                          ApplicantTiles(),
                        ]))
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

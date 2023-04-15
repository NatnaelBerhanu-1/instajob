// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/view_candidate.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/applicant_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/bottom_bloc/bottom_bloc.dart';

class Applicants extends StatelessWidget {
  const Applicants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppBar(
          onTap: () {
            // context
            //     .read<BottomCubit>()
            //     .setSelectedScreen(true, screenName: ViewCandidates());
            context
                .read<BottomBloc>()
                .add(SetScreenEvent(true, screenName: ViewCandidates()));
          },
          centerTitle: false,
          leadingImage: MyImages.backArrowBorder,
          title: "Applicants",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.06,
                      left: 0,
                      right: 0,
                      child: CustomCommonCard(
                        // height: 200,
                        borderRadius: BorderRadius.circular(15),
                        borderColor: MyColors.blue,
                        bgColor: MyColors.white,
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06),
                            CommonText(
                              text: "Tim Barbeque",
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                            ),
                            SizedBox(height: 5),
                            CommonText(
                              text: "Product Designer",
                              fontColor: MyColors.grey,
                              fontSize: 12,
                            ),
                            SizedBox(height: 15),
                            Divider(
                              color: MyColors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 8, right: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonText(
                                          text: "Location",
                                          fontColor: MyColors.grey,
                                          fontSize: 12,
                                        ),
                                        SizedBox(height: 5),
                                        CommonText(
                                          text: "Ann Arnor",
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonText(
                                          text: "Work experience",
                                          fontColor: MyColors.grey,
                                          fontSize: 12,
                                        ),
                                        SizedBox(height: 5),
                                        CommonText(
                                          text: "2+ year",
                                          // fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonText(
                                          text: "Applied on",
                                          fontColor: MyColors.grey,
                                          fontSize: 12,
                                        ),
                                        SizedBox(height: 5),
                                        CommonText(
                                          text: "21st February",
                                          // fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 8, right: 8, bottom: 20),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.blue),
                                    ),
                                    child: ListTile(
                                      dense: true,
                                      visualDensity:
                                          VisualDensity(vertical: -2),
                                      title: Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.file_present_sharp,
                                            color: MyColors.blue,
                                            size: 16,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Resume-2020.pdf",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: MyColors.black,
                                              overflow: TextOverflow.clip,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: MediaQuery.of(context).size.height * 0.175,
                      child: CircleAvatar(
                        radius: 40,
                        child: ImageButton(
                          image: MyImages.user,
                        ),
                      ),
                    )
                    // CachedNetworkImage(
                    //   imageUrl: MyImages.user,
                    // ),
                  ],
                ),
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
          )
        ],
      ),
    );
  }
}

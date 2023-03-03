// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_bloc.dart';
import 'package:insta_job/screens/insta_job_user/SliderScreen/tellus_about_yslf_page.dart';
import 'package:insta_job/screens/insta_job_user/SliderScreen/work_experience_screen.dart';
import 'package:insta_job/utils/my_colors.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  int sIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  PageController c = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    // var selectedIndex = context.watch<IndexBloc>().sIndex;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (c, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        // height: 11,
                        // width: 11,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sIndex == i ? MyColors.blue : MyColors.white,
                            border: Border.all(
                                color: sIndex == i
                                    ? MyColors.transparent
                                    : MyColors.blue)),
                      ),
                    );
                  }),
            ),
            Expanded(
                flex: 10,
                child: PageView(
                  allowImplicitScrolling: true,
                  scrollDirection: Axis.horizontal,
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    TellUsAboutYSlfPage(
                      onTap: () {
                        sIndex = 1;
                        // context.read<IndexBloc>().changeIndex(sIndex);
                        pageController.animateToPage(1,
                            duration: Duration(seconds: 1), curve: Curves.ease);
                      },
                    ),
                    PageView(
                      allowImplicitScrolling: true,
                      scrollDirection: Axis.horizontal,
                      // physics: NeverScrollableScrollPhysics(),
                      controller: c,
                      onPageChanged: (val) {
                        sIndex = val;
                        print("WWWW => $val");
                        setState(() {});
                      },
                      children: [
                        EducationScreen(
                          pageController: pageController,
                          onSkipTap: () {
                            sIndex = 1;
                          },
                        ),
                        EducationScreen(
                          // isWork: true,
                          pageController: pageController,
                          onSkipTap: () {
                            sIndex = 1;
                          },
                        ),
                      ],
                    ),
                    // EducationScreen(
                    //   pageController: pageController,
                    //   onSkipTap: () {
                    //     sIndex = 1;
                    //   },
                    // ),
                    Container(),
                    Container(),
                  ],
                  controller: pageController,
                  onPageChanged: (val) {
                    sIndex = val;
                    print("1st pageView value : $val");
                    setState(() {});
                  },
                ))
            // Expanded(child: Text('data'))
          ],
        ),
      ),
    ));
  }
}

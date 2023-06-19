// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/screens/resume_edit_screens/cv_template_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: MyImages.completedPana,
      text: "Well Designed Template",
      desc:
          "There are many By leveraging an algorithm that won a Nobel Prize in Economics that solves the... stable marriage problem",
    ),
    OnboardModel(
      img: MyImages.resumeImg,
      text: "Easy to Export",
      desc:
          "By leveraging an algorithm that won a Nobel Prize in Economics that solves the... stable marriage problem!",
    ),
    OnboardModel(
      img: MyImages.completedPana,
      text: "Easy to Edit",
      desc:
          "By leveraging an algorithm that won a Nobel Prize in Economics that solves the... stable marriage problem!"
          "By leveraging an algorithm that won a Nobel Prize in Economics that solves the... stable marriage problem",
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
        child: PageView.builder(
            itemCount: screens.length,
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(),
                  Expanded(
                      child: Image.asset(
                    screens[index].img,
                    fit: BoxFit.cover,
                  )),
                  SizedBox(height: 60),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0, color: MyColors.grey),
                  ),
                  Spacer(),
                  Container(
                    height: 10.0,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 12 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? MyColors.blue
                                      : MyColors.blue.withOpacity(.30),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    onTap: () {
                      // _pageController.animateToPage(currentIndex,
                      //     duration: Duration(seconds: 0),
                      //     curve: Curves.bounceIn);
                      // print(index);
                      // print(_pageController.page);

                      if (_pageController.page == 1) {
                        _pageController.jumpToPage(2);
                      } else if (_pageController.page == 2) {
                        AppRoutes.pushAndRemoveUntil(
                            context, CvTemplateScreen());
                      } else {
                        _pageController.jumpToPage(1);
                      }
                    },
                    title: "GET STARTED",
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class OnboardModel {
  String img;
  String text;
  String desc;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
  });
}

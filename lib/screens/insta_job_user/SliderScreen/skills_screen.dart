// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../widgets/custom_button/custom_btn.dart';
import '../../../widgets/custom_cards/custom_common_card.dart';

class SkillsScreen extends StatelessWidget {
  final PageController? pageController;

  SkillsScreen({
    Key? key,
    this.pageController,
  }) : super(key: key);
  TextEditingController topSkills = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: PreferredSize(
        //     preferredSize: Size(double.infinity, kToolbarHeight),
        //     child: CustomAppBar(
        //       title: "",
        //       leadingImage: MyImages.arrowBlueLeft,
        //       height: 15,
        //       width: 15,
        //     )),
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageButton(
                onTap: () {
                  pageController?.animateToPage(2,
                      duration: Duration(seconds: 1), curve: Curves.ease);
                },
                image: MyImages.arrowBlueLeft,
                padding: EdgeInsets.zero,
                height: 17,
                width: 17,
              ),
              SizedBox(width: 15),
              CommonText(
                text: "Skills",
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ],
          ),
          SizedBox(height: 10),
          Center(
              child: Image.asset(
            MyImages.resumeImg,
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          )),
          // SizedBox(height: 15),

          SizedBox(height: 15),
          BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
            var skillList = context.read<GlobalCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Skills",
                  style: TextStyle(
                      color: MyColors.black,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400),
                ),
                Expanded(
                  flex: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: topSkills,
                          hint: "",
                          textCapitalization: TextCapitalization.words,

                          // validator: (val) =>
                          //     validate.requiredValidation(
                          //         val!, "Skills"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (topSkills.text.isNotEmpty) {
                            skillList.topSkills(topSkills.text);
                            topSkills.clear();
                          } else {
                            showToast('Please fill the text');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0, left: 10, top: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                color: MyColors.blue, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Icon(
                                Icons.add,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
          /*CommonText(
            text: "Add Skills",
            fontWeight: FontWeight.w500,
            fontColor: MyColors.grey,
          ),
          SizedBox(height: 15),
          SkillsTile(
            title: "Photoshop",
          ),
          SkillsTile(
            title: "HTML 5",
          ),
          SkillsTile(
            title: "Photoshop",
            icon: Icons.remove,
            color: MyColors.lightRed,
          ),*/
          SizedBox(height: 15),
          CustomDivider(
            title: "Added",
            color: MyColors.black,
          ),
          SizedBox(height: 15),
          BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
            var skillList = context.read<GlobalCubit>();
            return skillList.skills.isEmpty
                ? SizedBox()
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 4 / 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    // primary: false,
                    shrinkWrap: true,
                    itemCount: skillList.skills.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyColors.lightBlue.withOpacity(.20),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText(
                                  text: skillList.skills[index],
                                  fontColor: MyColors.blue,
                                  fontSize: 13,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    skillList.removeSkill(index);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: MyColors.red,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
          }),
          /*  GridView.builder(
            itemCount: 7,
            shrinkWrap: true,
            itemBuilder: (i, c) => AddSkillTile(
              title: "Photoshop",
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 15 / 5),
          ),*/
          CustomButton(
            title: "Skip",
            bgColor: MyColors.white,
            fontColor: MyColors.black,
          ),
          CustomIconButton(
            title: "Continue",
            backgroundColor: MyColors.blue,
            borderColor: MyColors.blue,
            image: MyImages.arrowWhite, onclick: () {},
            // onclick: onContinueTap,
          ),
        ],
      ),
    ));
  }
}

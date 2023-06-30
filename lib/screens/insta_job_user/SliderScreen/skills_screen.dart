// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_state.dart';
import 'package:insta_job/bloc/resume_bloc/resume_bloc.dart';
import 'package:insta_job/bloc/resume_bloc/resume_event.dart';
import 'package:insta_job/bloc/resume_bloc/resume_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/resume_edit_screens/edit_template_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/skill_tile.dart';
import 'package:insta_job/widgets/custom_divider.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../widgets/custom_button/custom_btn.dart';
import '../../../widgets/custom_cards/custom_common_card.dart';

class SkillsScreen extends StatefulWidget {
  final PageController? pageController;

  SkillsScreen({
    Key? key,
    this.pageController,
  }) : super(key: key);

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  TextEditingController topSkills = TextEditingController();
  bool isAchievement = false;
  @override
  Widget build(BuildContext context) {
    var data = context.read<GlobalCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (isAchievement) {
                    isAchievement = false;
                    setState(() {});
                  } else {
                    widget.pageController?.jumpToPage(2);
                  }
                  context.read<GlobalCubit>().skills = context
                          .read<ResumeBloc>()
                          .resumeModel
                          .skills?[0]
                          .addSkill ??
                      [];
                },
                child: Container(
                  color: MyColors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 10.0, top: 8, bottom: 8),
                    child: Image.asset(
                      MyImages.arrowBlueLeft,
                      height: 17,
                      width: 17,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              CommonText(
                text: isAchievement ? "Achievements" : "Skills",
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
          SizedBox(height: 15),
          BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
            var skillList = context.read<GlobalCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add ${isAchievement ? "Achievement" : "Skills"}",
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
                            isAchievement
                                ? skillList.addAchievement(topSkills.text)
                                : skillList.topSkills(topSkills.text);
                            topSkills.clear();
                          } else {
                            showToast('Please fill the text');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0, left: 10, top: 9),
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
          if (isAchievement) ...[
            data.achievementList.isEmpty
                ? SizedBox()
                : CustomDivider(
                    title: "Added",
                    color: MyColors.black,
                  ),
          ] else ...[
            data.skills.isEmpty
                ? SizedBox()
                : CustomDivider(
                    title: "Added",
                    color: MyColors.black,
                  ),
          ],
          SizedBox(height: 15),
          BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
            var skillList = context.read<GlobalCubit>();
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 4 / 1.4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                primary: false,
                shrinkWrap: true,
                itemCount: isAchievement
                    ? skillList.achievementList.length
                    : skillList.skills.length,
                itemBuilder: (context, index) {
                  return AddSkillTile(
                    title: isAchievement
                        ? skillList.achievementList[index]
                        : skillList.skills[index],
                    onTap: () {
                      if (isAchievement) {
                        skillList.removeAchievement(index);
                      } else {
                        skillList.removeSkill(index);
                      }
                    },
                  );
                  /*return Container(
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
                      );*/
                });
          }),
          SizedBox(height: 15),
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
          // SizedBox(height: 100),
          isAchievement
              ? CustomButton(
                  title: "Skip",
                  bgColor: MyColors.white,
                  fontColor: MyColors.black,
                  onTap: () {
                    AppRoutes.push(context, EditTemplateScreen());
                  },
                )
              : CustomButton(
                  title: "Skip",
                  bgColor: MyColors.white,
                  fontColor: MyColors.black,
                  onTap: () {
                    isAchievement = true;
                    setState(() {});
                  },
                ),
          BlocBuilder<ResumeBloc, ResumeState>(builder: (context, state) {
            return CustomIconButton(
              title: "Continue",
              backgroundColor: MyColors.blue,
              borderColor: MyColors.blue,
              image: MyImages.arrowWhite,
              onclick: () {
                if (isAchievement) {
                  if (data.skills.isNotEmpty) {
                    context.read<ResumeBloc>().add(AddAchievementEvent(
                        context.read<GlobalCubit>().achievementList));
                    context.read<ResumeBloc>().add(UserResumeLoadedEvent());
                    AppRoutes.push(context, EditTemplateScreen());
                  }
                } else {
                  if (data.skills.isNotEmpty) {
                    context.read<ResumeBloc>().add(
                        AddSkillsEvent(context.read<GlobalCubit>().skills));
                  }
                  if (context.read<GlobalCubit>().achievementList.isNotEmpty) {
                    context.read<GlobalCubit>().achievementList = context
                            .read<ResumeBloc>()
                            .resumeModel
                            .achievements?[0]
                            .achievements ??
                        [];
                  }
                }

                isAchievement = true;
                setState(() {});
              },
              // onclick: onContinueTap,
            );
          }),
        ],
      ),
    );
  }
}

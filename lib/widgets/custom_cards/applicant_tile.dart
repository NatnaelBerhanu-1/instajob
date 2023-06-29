// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/model/resume_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_divider.dart';

class ApplicantTiles extends StatelessWidget {
  final ResumeModel? resumeModel;
  const ApplicantTiles({Key? key, this.resumeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: resumeModel?.skills?.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: .0, horizontal: 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${resumeModel?.skills?[i].addSkill}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Spacer(),
                          Icon(
                            Icons.check_circle_outline_rounded,
                            color: MyColors.blue,
                          ),
                        ],
                      ),
                      divider()
                    ],
                  ),
                );
              }),
        ),
        /*Expanded(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                  height: MediaQuery.of(context).size.height * 0.055,
                  title: "Contact",
                )),
                SizedBox(width: 15),
                Expanded(
                    child: CustomButton(
                  height: MediaQuery.of(context).size.height * 0.055,
                  bgColor: MyColors.lightRed,
                  title: "Deny",
                )),
              ],
            ),
          ),
        )*/
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:insta_job/model/job_position_model.dart';

import '../utils/my_colors.dart';
import 'custom_cards/custom_common_card.dart';

class CustomExpansionTile extends StatefulWidget {
  final String? title;
  final Widget children;
  final IconData? isExpandedIcon;
  final IconData? isNotExpandedIcon;
  final Color? borderColor;
  const CustomExpansionTile(
      {Key? key,
      this.title,
      required this.children,
      this.isExpandedIcon,
      this.isNotExpandedIcon,
      this.borderColor})
      : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: isExpanded
                      ? widget.borderColor ?? MyColors.transparent
                      : MyColors.grey.withOpacity(.30))),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              onExpansionChanged: (val) {
                isExpanded = val;
                setState(() {});
              },
              trailing: Icon(
                isExpanded
                    ? widget.isExpandedIcon ?? Icons.arrow_drop_up_outlined
                    : widget.isNotExpandedIcon ?? Icons.arrow_drop_down_sharp,
                size: 25,
                color: MyColors.blue,
              ),
              title: Text(
                "${widget.title}",
                style: TextStyle(color: MyColors.black),
              ),
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, bottom: 10),
                    child: widget.children,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 17),
      ],
    );
  }
}

Widget buildTopSkillsTile(JobPosModel jobPosModel) {
  return CustomExpansionTile(
      title: "Top Skills",
      children: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(jobPosModel.topSkills!.length, (index) {
                // print("TOPPPPPPPPPPPPPPPPP ${jobPosModel.topskills?[index]}");
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CustomCommonCard(
                    bgColor: MyColors.lightBlue.withOpacity(.20),
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommonText(
                        text: jobPosModel.topSkills?[index],
                        fontColor: MyColors.blue,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ));
}

Widget buildResponsibilityTile(JobPosModel jobPosModel) {
  return CustomExpansionTile(
      title: "Responsibilities",
      children: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 0,
                child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: MyColors.blue,
                      shape: BoxShape.circle,
                    )),
              ),
              SizedBox(width: 7),
              Expanded(
                child: CommonText(
                  text: jobPosModel.responsibilities,
                  fontSize: 13,
                  fontColor: MyColors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Row(
          //   children: [
          //     Container(
          //         height: 8,
          //         width: 8,
          //         decoration: BoxDecoration(
          //           color: MyColors.blue,
          //           shape: BoxShape.circle,
          //         )),
          //     SizedBox(width: 7),
          //     CommonText(
          //       text: "Lorem ipsum dolor sit amet, consectetur adipiscing ",
          //       fontSize: 13,
          //       fontColor: MyColors.grey,
          //     ),
          //   ],
          // ),
          // SizedBox(height: 8),
          // Row(
          //   children: [
          //     Container(
          //         height: 8,
          //         width: 8,
          //         decoration: BoxDecoration(
          //           color: MyColors.blue,
          //           shape: BoxShape.circle,
          //         )),
          //     SizedBox(width: 7),
          //     CommonText(
          //       text: "Lorem ipsum dolor sit amet, consectetur adipiscing ",
          //       fontSize: 13,
          //       fontColor: MyColors.grey,
          //     ),
          //   ],
          // ),
        ],
      ));
}

Widget buildRequirementTile(JobPosModel jobPosModel) {
  return CustomExpansionTile(
      title: "Requirements",
      children: Text("${jobPosModel.requirements}",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 13,
            color: MyColors.grey,
          )));
}

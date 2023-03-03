// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../utils/my_colors.dart';
import '../custom_common_card.dart';

class SkillsTile extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Color? color;
  const SkillsTile({
    Key? key,
    this.title,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.grey.withOpacity(.50)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CommonText(
                  text: title,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: color ?? MyColors.blue, width: 1.3),
                    shape: BoxShape.circle),
                child: Icon(icon ?? Icons.add, color: color ?? MyColors.blue),
              ),
            ),
          ],
        ),
        SizedBox(height: 7)
      ],
    );
  }
}

class AddSkillTile extends StatelessWidget {
  final String? title;
  final Color? color;
  const AddSkillTile({
    Key? key,
    this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grey.withOpacity(.50)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text("$title",
                softWrap: true,
                style: TextStyle(
                  fontSize: 13,
                )),
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 0,
            child: Container(
              // padding: EdgeInsets.all(0),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(
                Icons.cancel_outlined,
                color: color ?? MyColors.blue,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

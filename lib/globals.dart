import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';

BoxShadow boxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.25),
  offset: const Offset(0, 4),
  spreadRadius: 2,
  blurRadius: 4,
);

BoxShadow blueBoxShadow = BoxShadow(
  color: MyColors.lightBlue.withOpacity(0.15),
  offset: const Offset(0, 5),
  spreadRadius: 5,
  blurRadius: 10,
);

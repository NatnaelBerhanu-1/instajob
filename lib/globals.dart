import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';

BoxShadow boxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.25),
  offset: const Offset(0, 4),
  spreadRadius: 2,
  blurRadius: 4,
);

BoxShadow blueBoxShadow = BoxShadow(
  color: MyColors.lightBlue.withOpacity(0.10),
  offset: const Offset(0, 5),
  spreadRadius: 5,
  blurRadius: 10,
);
BoxShadow normalBoxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.10),
  offset: const Offset(0, 4),
  spreadRadius: 2,
  blurRadius: 7,
);
// Future<T?> push<T>({
//   bool pushUntil = false,
//   required BuildContext context,
//   required Widget screen,
// }) {
//   if (pushUntil) {
//     return Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => screen),
//         (Route<dynamic> route) => false);
//   }
//   return Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
// }

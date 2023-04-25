// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

// class ConfirmDetailTile extends StatelessWidget {
//   // final String? title;
//   final String? heading;
//   final String? hint;
//   final int? maxLine;
//   final TextEditingController? controller;
//   const ConfirmDetailTile({
//     Key? key,
//     // this.title,
//     this.heading,
//     this.hint,
//     this.controller,
//     this.maxLine,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CommonText(
//           text: "$heading",
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//         SizedBox(height: 9),
//         TextFormField(
//           controller: controller,
//           style: TextStyle(color: MyColors.black, fontSize: 14),
//           maxLines: maxLine,
//           decoration: InputDecoration(
//             isDense: true,
//             hintText: hint,
//             suffixIcon: Padding(
//               padding: const EdgeInsets.only(right: 10.0),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   CommonText(
//                     text: "Confirm",
//                     fontColor: Colors.orange,
//                   ),
//                   SizedBox(width: 10),
//                   CommonText(
//                     text: "Edit",
//                     fontColor: MyColors.blue,
//                   ),
//                 ],
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//               borderSide: BorderSide(color: MyColors.lightgrey, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//               borderSide: BorderSide(color: MyColors.lightgrey, width: 1),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//               borderSide: BorderSide(color: MyColors.lightgrey, width: 1),
//             ),
//           ),
//         ),
//         /* CustomCommonCard(
//           borderColor: MyColors.grey.withOpacity(.30),
//           borderRadius: BorderRadius.circular(7),
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(child: child),
//                 // Spacer(),
//                 Expanded(
//                   flex: 0,
//                   child: CommonText(
//                     text: "Confirm",
//                     fontColor: Colors.orange,
//                   ),
//                 ),
//                 SizedBox(width: 15),
//                 Expanded(
//                   flex: 0,
//                   child: CommonText(
//                     text: "Edit",
//                     fontColor: MyColors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),*/
//       ],
//     );
//   }
// }
Padding buildSuffix({
  VoidCallback? confirm,
  VoidCallback? edit,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: confirm,
          child: CommonText(
            text: "Confirm",
            fontColor: Colors.orange,
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: edit,
          child: CommonText(
            text: "Edit",
            fontColor: MyColors.blue,
          ),
        ),
      ],
    ),
  );
}

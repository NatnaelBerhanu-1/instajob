// import 'package:flutter/material.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
//
// class BSheet extends StatelessWidget {
//   const BSheet({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       extendBody: true, // m
//       bottomSheet: Container(
//         color: Colors.black,
//         child: SolidBottomSheet(
//           headerBar: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Stack(
//                 children: [
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     top: 35 / 2, //35 from text top padding widget
//                     child: Container(
//                       decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(24),
//                             topRight: Radius.circular(24),
//                           )),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(
//                       top: 35,
//                     ),
//                     alignment: Alignment.center,
//                     child: const Center(
//                       child: Text(
//                         "Show More`enter code here`",
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   ),
//                   const Align(
//                     alignment: Alignment.topCenter,
//                     child: Card(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Icon(Icons.keyboard_double_arrow_up,
//                             color: Colors.red),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           body: Container(
//             color: Colors.white,
//             height: 130,
//             child: Center(
//               child: Text(
//                 "Hello! I'm a bottom sheet :D",
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

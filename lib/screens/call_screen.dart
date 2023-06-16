// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 150,
                width: 150,
                color: MyColors.white,
                child: Stack(
                  children: [
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MyColors.grey,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 58,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: MyColors.blue),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Icon(Icons.camera_alt, color: MyColors.white),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            color: MyColors.black.withOpacity(.80),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(child: CustomCallButtons()),
                  Expanded(child: CustomCallButtons()),
                  Expanded(
                    child: FloatingActionButton(
                      backgroundColor: MyColors.red,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.call_end),
                    ),
                  ),
                  Expanded(child: CustomCallButtons()),
                  Expanded(child: CustomCallButtons()),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class CustomCallButtons extends StatelessWidget {
  final String? image;
  final VoidCallback? onTap;
  const CustomCallButtons({
    super.key,
    this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyColors.lightgrey.withOpacity(.50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(Icons.class_),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_state.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

leaveSheet(BuildContext context, {required PageController pageController}) {
  return showModalBottomSheet(
      backgroundColor: MyColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      )),
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(MyImages.resume, height: 120, width: 120),
                // SizedBox(height: 10),
                Center(
                  child: CommonText(
                    text: "Do you want to leave this",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Center(
                  child: CommonText(
                    text: "Section Blank?",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Text("• ",
                                    style: TextStyle(
                                        fontSize: 22, color: MyColors.blue)),
                              ),
                              Expanded(
                                  child: Text("Volunteer",
                                      style: TextStyle(fontSize: 14))),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Text("• ",
                                    style: TextStyle(
                                        fontSize: 22, color: MyColors.blue)),
                              ),
                              Expanded(
                                child: Text(
                                  "Tutor",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Text("• ",
                                    style: TextStyle(
                                        fontSize: 22, color: MyColors.blue)),
                              ),
                              Expanded(
                                child: Text("BabySitter",
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Text("• ",
                                    style: TextStyle(
                                        fontSize: 22, color: MyColors.blue)),
                              ),
                              Expanded(
                                child: Text("Dog Walker",
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ],
                          )
                        ],
                      )),
                      SizedBox(width: 30),
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Text("• ",
                                    style: TextStyle(
                                        fontSize: 22, color: MyColors.blue)),
                              ),
                              Expanded(
                                child: Text("Teaching Assistant",
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Text("• ",
                                    style: TextStyle(
                                        fontSize: 22, color: MyColors.blue)),
                              ),
                              Expanded(
                                child: Text(
                                  "Office Helper",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Text("• ",
                                    style: TextStyle(
                                        fontSize: 22, color: MyColors.blue)),
                              ),
                              Expanded(
                                  child: Text("WorkStudy",
                                      style: TextStyle(fontSize: 14))),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Text("• ",
                                    style: TextStyle(
                                        fontSize: 22, color: MyColors.blue)),
                              ),
                              Expanded(
                                child: Text("Data Entry Clerk",
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ],
                          )
                        ],
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DottedButton(
                        title: "Add Title",
                        bgColor: MyColors.white,
                        onTap: () {
                          Navigator.pop(context);
                          // AppRoutes.push(context, AddCardScreen());
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        title: "Skip For Now  〉",
                        onTap: () {
                          Navigator.pop(context);
                          pageController.jumpToPage(3);
                        },
                        // fontSize: 10,
                        // image: MyImages.arrowWhite,
                      ),
                    )
                  ],
                ),
                // Image.asset(MyImages.resume),
                // Column(),
              ],
            ),
          ),
        );
      });
}

choosePhoto(context) {
  return showModalBottomSheet(
      backgroundColor: MyColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      context: context,
      builder: (_) =>
          BlocBuilder<PickImageCubit, InitialImage>(builder: (context, state) {
            var imageBloc = context.read<PickImageCubit>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    print("Camera");
                    imageBloc.isCamera = true;
                    Navigator.pop(context);
                    await imageBloc.getImage();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.camera_alt,
                            size: 25,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Camera", style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    print("Gallery");
                    imageBloc.isCamera = false;
                    Navigator.pop(context);
                    await imageBloc.getImage();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.photo,
                            size: 25,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            );
          }));
}

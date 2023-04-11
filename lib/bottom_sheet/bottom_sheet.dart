// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_state.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';

leaveSheet(BuildContext context) {
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
          body: SizedBox(
            height: 500,
            child: Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: MyColors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                ),
                Image.asset(MyImages.resume),
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

class NewEmailScreen extends StatefulWidget {
  const NewEmailScreen({Key? key}) : super(key: key);

  @override
  State<NewEmailScreen> createState() => _NewEmailScreenState();
}

class _NewEmailScreenState extends State<NewEmailScreen> {
  var border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: MyColors.grey.withOpacity(.30), width: 1),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: "New Email",
          leadingImage: MyImages.cancel4x,
          imageColor: MyColors.blue,
          height: 16,
          width: 16,
          leadingWidth: 40,
          // leadingImage: MyImages.,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 17, top: 25, bottom: 10),
                      prefixIcon: Center(widthFactor: 0, child: Text("To:")),
                      hintText: "teresawilliam@gmail.com",
                      hintStyle: TextStyle(
                        color: MyColors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      errorBorder: border,
                      focusedErrorBorder: border,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 17, top: 25, bottom: 10),
                      hintText: "  Design Request Proposal",
                      hintStyle: TextStyle(
                        color: MyColors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                      prefixIcon: Center(
                          widthFactor: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7.0),
                            child: Text(
                              "Subject:",
                              style: TextStyle(fontSize: 11),
                            ),
                          )),
                      // prefixText: "Subject: ",
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      errorBorder: border,
                      focusedErrorBorder: border,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    maxLine: 10,
                    color: MyColors.grey.withOpacity(.30),
                    hint: "Description",
                  ),
                ],
              ),
            ),
            // Spacer(),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.33),
            Expanded(
              flex: 0,
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color: MyColors.lightgrey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: ImageButton(
                          image: MyImages.delete,
                          color: MyColors.grey,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: ImageButton(
                          image: MyImages.visible,
                          color: MyColors.grey,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Spacer(),
                      // Expanded(
                      //   flex: 0,
                      //   child: Icon(
                      //     Icons.link,
                      //     color: MyColors.grey,
                      //   ),
                      // ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(MyColors.blue),
                        ),
                        child: Text("Send Now"),
                      ))
                    ],
                  ),
                ),
              ),
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}

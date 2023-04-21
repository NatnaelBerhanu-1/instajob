// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_images.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_button/custom_img_button.dart';
import '../../widgets/custom_cards/assign_companies_tile.dart';
import '../../widgets/custom_cards/custom_common_card.dart';

class ChangeAccInfoScreen extends StatelessWidget {
  final bool isRecruitInterface;

  const ChangeAccInfoScreen({Key? key, this.isRecruitInterface = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 13.0, left: 5),
                          child: ImageButton(
                            onTap: () {
                              AppRoutes.pop(context);
                            },
                            image: MyImages.backArrow,
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Image.asset(
                          MyImages.bgCurve,
                          color: MyColors.grey.withOpacity(.10),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(MyImages.instaLogo_),
                                CommonText(
                                  text: "Employee instantly",
                                  fontColor: MyColors.grey,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Change Account Information",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Edit Information",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: MyColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30),
                      IconTextField(
                        prefixIcon: ImageButton(
                          image: MyImages.userFilled,
                          padding: EdgeInsets.all(14),
                          height: 10,
                          width: 10,
                        ),
                        suffixIcon: ImageButton(image: MyImages.verified),
                        hint: "Company Name",
                      ),
                      SizedBox(height: 15),
                      IconTextField(
                        prefixIcon: ImageButton(
                          image: MyImages.email,
                          padding: EdgeInsets.all(14),
                          height: 10,
                          width: 10,
                        ),
                        suffixIcon: ImageButton(image: MyImages.verified),
                        hint: "alexies@mygmail.com",
                      ),
                      isRecruitInterface ? SizedBox() : SizedBox(height: 15),
                      isRecruitInterface
                          ? SizedBox()
                          : IconTextField(
                              // onTap: () {},
                              label: "Date of Birth",
                              hint: "03/10/1998",
                              readOnly: true,
                              hintColor: MyColors.grey,
                              prefixIcon: ImageButton(image: MyImages.cal),
                              suffixIcon: Icon(Icons.arrow_drop_down_sharp,
                                  color: MyColors.black, size: 25),

                              // validator: (val) =>
                              //     validation.requiredValidation1(val),
                              // validator: widget.isUpdate == true
                              //     ? null
                              //     : (String? val) {
                              //         if (val!.isEmpty) {
                              //           isRequired = val.isEmpty;
                              //           setState(() {});
                              //         }
                              //         // value.validation(val!);
                              //         print('vallll Date-- ${isRequired}');
                              //         Validation.requiredValidation(val);
                              //         return null;
                              //       },
                            ),
                      isRecruitInterface ? SizedBox() : SizedBox(height: 15),
                      isRecruitInterface
                          ? SizedBox()
                          : IconTextField(
                              prefixIcon: ImageButton(
                                image: MyImages.lock,
                                padding: EdgeInsets.all(14),
                                height: 10,
                                width: 10,
                              ),
                              suffixIcon: ImageButton(image: MyImages.visible),
                              hint: "password",
                            ),
                      SizedBox(height: 10),
                      CustomPhonePickerTextField(),
                      SizedBox(height: 15),
                      Text(
                        "Upload Photo",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: MyColors.grey),
                      ),
                      SizedBox(height: 10),
                      uploadPhotoCard(context),
                      SizedBox(height: 50),
                      CustomIconButton(
                        image: MyImages.arrowWhite,
                        title: "Change Information",
                        backgroundColor: MyColors.blue,
                        fontColor: MyColors.white,
                        borderColor: MyColors.blue,
                        iconColor: MyColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

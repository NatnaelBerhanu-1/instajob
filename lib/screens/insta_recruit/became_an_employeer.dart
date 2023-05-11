// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/auth_screen/verify_code_screen.dart';
import 'package:insta_job/screens/insta_recruit/welcome_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../widgets/custom_button/custom_btn.dart';

class BecameAnEmployer extends StatefulWidget {
  final bool isUpdate;
  const BecameAnEmployer({Key? key, this.isUpdate = false}) : super(key: key);

  @override
  State<BecameAnEmployer> createState() => _BecameAnEmployerState();
}

class _BecameAnEmployerState extends State<BecameAnEmployer> {
  final formKey = GlobalKey<FormState>();
  TextEditingController website = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool isValid = false;

  update() {
    var userImage = context.read<PickImageCubit>();
    var model = Global.userModel!;
    companyName.text = model.email ?? "";
    phone.text = model.phoneNumber ?? "";
    website.text = model.websiteLink ?? "";
    isValid = model.phoneNumber != null ? true : false;
    userImage.imgUrl = model.uploadPhoto ?? "";
    setState(() {});
  }

  @override
  void initState() {
    if (widget.isUpdate) {
      update();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: formKey,
        child: Stack(
          children: [
            Image.asset(
              MyImages.sCurve,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.48,
              fit: BoxFit.fitHeight,
              // color: MyColors.lightgrey,
            ),
            Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Spacer(),
                          ImageButton(
                              onTap: () {
                                AppRoutes.pushAndRemoveUntil(
                                    context, WelcomeScreen());
                              },
                              image: MyImages.backArrow,
                              height: 30,
                              width: 30),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: "Became An Employer",
                                fontColor: MyColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              SizedBox(height: 20),
                              CommonText(
                                text: "Add client information and Job details",
                                fontSize: 13,
                              ),
                            ],
                          ),
                          Spacer()
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        IconTextField(
                          controller: companyName,
                          prefixIcon: ImageButton(
                            image: MyImages.userFilled,
                            padding: EdgeInsets.all(14),
                            height: 10,
                            width: 10,
                          ),
                          // suffixIcon: formKey.currentState!.validate()
                          //     ? SizedBox()
                          //     : verifyImage,
                          hint: "Company Name",
                          validator: (val) =>
                              requiredValidation(val!, "Company name"),
                          onChanged: (val) {
                            if (!formKey.currentState!.validate()) {
                              requiredValidation(val!, "Company name");
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        widget.isUpdate
                            ? IconTextField(
                                controller: phone,
                                prefixIcon: ImageButton(
                                  image: MyImages.phone,
                                  padding: EdgeInsets.all(16),
                                  height: 10,
                                  width: 10,
                                ),
                                readOnly: true,
                                hintColor: MyColors.black,
                                hint: Global.userModel?.phoneNumber,
                              )
                            : CustomPhonePickerTextField(
                                validator: (val) {
                                  return null;
                                },
                                controller: phone,
                                onInputValidated: (val) {
                                  isValid = val;
                                  setState(() {});
                                  if (val == true) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  }
                                  print("VAL  ::: $val");
                                },
                              ),
                        SizedBox(height: 20),
                        IconTextField(
                          controller: website,
                          prefixIcon: ImageButton(
                            image: MyImages.internet,
                            padding: EdgeInsets.all(14),
                            height: 10,
                            width: 10,
                          ),
                          suffixIcon: SizedBox(),
                          hint: "www.organize.com",
                          validator: (val) => hasValidUrl(val!, "Website"),
                          onChanged: (val) {
                            if (!formKey.currentState!.validate()) {
                              hasValidUrl(val!, "Website");
                            }
                          },
                        ),
                        SizedBox(height: 60),
                        uploadPhotoCard(context,
                            isUpdate: widget.isUpdate ? true : false,
                            url: context.read<PickImageCubit>().imgUrl),
                        SizedBox(height: 40),
                        BlocBuilder<AuthCubit, AuthInitialState>(
                            builder: (context, state) {
                          var authData = context.read<AuthCubit>();
                          var image = context.read<PickImageCubit>();
                          return CustomIconButton(
                            image: MyImages.arrowWhite,
                            title: "Next",
                            backgroundColor: MyColors.blue,
                            fontColor: MyColors.white,
                            borderColor: MyColors.blue,
                            iconColor: MyColors.blue,
                            onclick: () {
                              if (formKey.currentState!.validate()) {
                                if (phone.text.isEmpty ||
                                    image.imgUrl.isEmpty) {
                                  showToast("Please fill all details");
                                } else {
                                  if (isValid) {
                                    if (image.imgUrl.isNotEmpty) {
                                      authData.phoneNumber = phone.text;
                                      authData.companyName = companyName.text;
                                      authData.website = website.text;
                                      authData.profilePic = image.imgUrl;
                                      authData.getData();
                                      setState(() {});
                                      AppRoutes.push(
                                          context, VerifyCodeScreen());
                                    } else {
                                      showToast("Please upload photo");
                                    }
                                  } else {
                                    showToast("Enter valid phone number");
                                  }
                                }
                              }
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

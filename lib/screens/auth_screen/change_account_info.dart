// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_state.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/auth_screen/pdf_viewing_screen.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_images.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_button/custom_img_button.dart';
import '../../widgets/custom_cards/assign_companies_tile.dart';
import '../../widgets/custom_cards/custom_common_card.dart';

class ChangeAccInfoScreen extends StatefulWidget {
  // final bool isUpdate;
  const ChangeAccInfoScreen({super.key});

  @override
  State<ChangeAccInfoScreen> createState() => _ChangeAccInfoScreenState();
}

class _ChangeAccInfoScreenState extends State<ChangeAccInfoScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  final formKey = GlobalKey<FormState>();

  InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.lightgrey, width: 1), borderRadius: BorderRadius.circular(10));

  update() {
    var userImage = context.read<PickImageCubit>();
    var model = Global.userModel!;
    debugPrint('User: ${model.toJson()}');
    if (Global.userModel?.type == "user") {
      email.text = model.email ?? "";
      name.text = model.name ?? "";
      selectedDate = model.date ?? "";
      phone.text = model.phoneNumber ?? "";
      userImage.imgUrl = model.uploadPhoto ?? "";
      userImage.cvUrl = model.cv ?? "";
    } else {
      print("########################## ${model.companyName}");
      name.text = model.companyName ?? "";
      email.text = model.email ?? "";
      phone.text = model.phoneNumber ?? "";
      userImage.imgUrl = model.uploadPhoto ?? "";
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Form(
        key: formKey,
        child: SafeArea(
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
                                    text: "Employ instantly",
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
                    child: BlocBuilder<ValidationCubit, InitialValidation>(builder: (context, state) {
                      // var validationBloc = context.read<ValidationCubit>();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Change Account Information",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
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
                            controller: name,
                            prefixIcon: ImageButton(
                              image: MyImages.userFilled,
                              padding: EdgeInsets.all(14),
                              height: 10,
                              width: 10,
                            ),
                            validator: (val) =>
                                requiredValidation(val!, Global.userModel?.type == "user" ? "Name" : "Company name"),
                            onChanged: (val) {
                              if (!formKey.currentState!.validate()) {
                                requiredValidation(val!, Global.userModel?.type == "user" ? "Name" : "Company name");
                              }
                            },
                            // suffixIcon: ImageButton(image: MyImages.verified),
                            hint: Global.userModel?.type == "user" ? "FirstName" : "Company Name",
                          ),
                          SizedBox(height: 15),
                          IconTextField(
                            controller: email,
                            prefixIcon: ImageButton(
                              image: MyImages.email,
                              padding: EdgeInsets.all(14),
                              height: 10,
                              width: 10,
                            ),
                            readOnly: true,
                            validator: (val) => emailValidation(val!),
                            onChanged: (val) {
                              if (!formKey.currentState!.validate()) {
                                emailValidation(val!);
                              }
                            },
                            // suffixIcon: ImageButton(image: MyImages.verified),
                            hint: "alexies@mygmail.com",
                          ),
                          Global.userModel?.type != "user" ? SizedBox() : SizedBox(height: 15),
                          Global.userModel?.type != "user"
                              ? SizedBox()
                              : IconTextField(
                                  onPressed: () {
                                    chooseDate();
                                  },
                                  label: "Date of Birth",
                                  hint: selectedDate.isEmpty ? "DD-MM-YYY" : selectedDate,
                                  readOnly: true,
                                  hintColor: selectedDate.isEmpty ? MyColors.grey : MyColors.black,
                                  prefixIcon: ImageButton(
                                    image: MyImages.cal,
                                    padding: EdgeInsets.all(12),
                                    height: 10,
                                    width: 10,
                                  ),
                                  suffixIcon: Icon(Icons.arrow_drop_down_sharp, color: MyColors.black, size: 25),
                                ),
                          Global.userModel?.type != "user" ? SizedBox() : SizedBox(height: 15),
                          Global.userModel?.type == "user" ? SizedBox() : SizedBox(height: 15),
                          // widget.isUpdate
                          //     ?
                          IconTextField(
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
                          ),
                          //     :
                          // CustomPhonePickerTextField(
                          //         controller: phone,
                          //         validator: (val) {},
                          //       ),
                          SizedBox(height: 15),
                          Text(
                            "Upload Photo",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.w400, color: MyColors.grey),
                          ),
                          SizedBox(height: 10),
                          uploadPhotoCard(context, isUpdate: true, url: context.read<PickImageCubit>().imgUrl),
                          SizedBox(height: 12),

                          Visibility(
                            visible: Global.userModel?.type == "user",
                            child: BlocBuilder<PickImageCubit, InitialImage>(buildWhen: (c, state) {
                              if (state is PickCVImageState || state is ClearImageState) {
                                return true;
                              }
                              return false;
                            }, builder: (context, state) {
                              // var image = context.read<PickImageCubit>();
                              if (state is PickCVImageState || context.read<PickImageCubit>().cvUrl.isNotEmpty) {
                                return GestureDetector(
                                  onTap: () {
                                    AppRoutes.push(
                                        context, PdfViewingScreen(cvUrl: context.read<PickImageCubit>().cvUrl));
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Text(state.cvUrl.split('/').last),
                                          Text(context.read<PickImageCubit>().cvUrl.split('/').last), //TODO: revisit
                                          IconButton(
                                              visualDensity: VisualDensity.compact,
                                              onPressed: () {
                                                // context
                                                //     .read<PickImageCubit>()
                                                //     .clearCVUrl();
                                                // setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.clear,
                                                color: MyColors.red,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (state is LoadingImageState) {
                                return CircularProgressIndicator();
                              }
                              if (state is ClearImageState) {
                                return SizedBox();
                              }
                              return SizedBox();
                            }),
                          ),
                          SizedBox(height: 20),
                          Visibility(
                            visible: Global.userModel?.type == "user",
                            child: BlocBuilder<PickImageCubit, InitialImage>(
                                //   buildWhen: (c, state) {
                                // if (state is PickCVImageState) {
                                //   return true;
                                // }
                                // return false;
                                // },
                                builder: (context, state) {
                              var image = context.read<PickImageCubit>();
                              return CustomButton(
                                title: "Update your CV",
                                bgColor: MyColors.white,
                                borderColor: MyColors.blue,
                                fontColor: MyColors.blue,
                                onTap: () {
                                  image.getCvImage();
                                  debugPrint("LOG here cv img -> ${image.cvUrl} ORR? ${Global.userModel?.cv}");
                                },
                              );
                            }),
                          ),
                          SizedBox(height: 30),
                          BlocBuilder<AuthCubit, AuthInitialState>(builder: (context, state) {
                            var authData = context.read<AuthCubit>();
                            var image = context.read<PickImageCubit>();
                            return CustomIconButton(
                              image: MyImages.arrowWhite,
                              title: "Change Information",
                              loading: state is AuthLoadingState ? true : false,
                              backgroundColor: MyColors.blue,
                              fontColor: MyColors.white,
                              borderColor: MyColors.blue,
                              iconColor: MyColors.white,
                              onclick: () {
                                if (formKey.currentState!.validate()) {
                                  if (phone.text.isEmpty || selectedDate.isEmpty) {
                                    showToast("Please fill all details");
                                  } else {
                                    if (Global.userModel?.type == "user") {
                                      var cvUrl = context.read<PickImageCubit>().cvUrl;
                                      debugPrint('Image[URL]: ${image.imgUrl}');

                                      authData.updateUserData(
                                        profilePhoto: image.imgUrl,
                                        dOB: selectedDate,
                                        name: name.text,
                                        phoneNumber: phone.text,
                                        resumeOrCv: cvUrl,
                                      );
                                    } else {
                                      authData.updateEmpData(
                                        profilePhoto: image.imgUrl,
                                        name: name.text,
                                      );
                                    }
                                    image.clearImgUrl();
                                    // if (widget.isUpdate) {
                                    //
                                    // } else {
                                    //   authData.dob = selectedDate;
                                    //   authData.phoneNumber = phone.text;
                                    //   authData.profilePic = image.imgUrl;
                                    //   setState(() {});
                                    //   // authData.getData();
                                    //   // AppRoutes.push(
                                    //   //     context, VerifyCodeScreen());
                                    // }
                                    // } else {
                                    //   showToast("Please enter valid number");
                                    // }
                                  }
                                } else {
                                  print("333333333333333");
                                }
                              },
                            );
                          }),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String selectedDate = userType == "user" ? "" : "${DateTime.now()}";

  chooseDate() async {
    DateTime date = DateTime.now();
    date = await selectDate(context, date);
    selectedDate = DateFormat('dd-MM-yyyy').format(date);
    print(" //////// $selectedDate");
    setState(() {});
  }
}

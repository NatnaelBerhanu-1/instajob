// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/auth_screen/verify_code_screen.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../utils/my_images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';
import '../../widgets/custom_text_field.dart';

class RegMoreInfoScreen extends StatefulWidget {
  const RegMoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<RegMoreInfoScreen> createState() => _RegMoreInfoScreenState();
}

class _RegMoreInfoScreenState extends State<RegMoreInfoScreen> {
  TextEditingController phone = TextEditingController();
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            onTap: () {
              // AppRoutes.pushAndRemoveUntil(context, WelcomeScreen());
              Navigator.of(context).pop();
            },
            title: "",
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please Enter More Information",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 40),
              IconTextField(
                onPressed: () {
                  chooseDate(context);
                },
                label: "Date of Birth",
                hint: selectedDate.isEmpty ? "DD-MM-YYY" : selectedDate,
                readOnly: true,
                hintColor:
                    selectedDate.isEmpty ? MyColors.grey : MyColors.black,
                prefixIcon: ImageButton(
                  image: MyImages.cal,
                  padding: EdgeInsets.all(12),
                  height: 10,
                  width: 10,
                ),
                suffixIcon: Icon(Icons.arrow_drop_down_sharp,
                    color: MyColors.black, size: 25),
              ),
              SizedBox(height: 30),
              CustomPhonePickerTextField(
                controller: phone,
                label: "Phone Number",
                onInputValidated: (val) {
                  isValid = val;
                  setState(() {});
                  if (val == true) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                onInputChanged: (PhoneNumber number) async {
                  context.read<AuthCubit>().countryCode = number.dialCode ?? "";
                  print(
                      "COUNTRY CODE -->  ${context.read<AuthCubit>().countryCode}");
                },
                // validator: (val) {},
              ),
              SizedBox(height: 10),
              Text(
                "Upload Photo",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: MyColors.grey),
              ),
              SizedBox(height: 10),
              uploadPhotoCard(context),
              SizedBox(height: 20),
              BlocBuilder<PickImageCubit, InitialImage>(buildWhen: (c, state) {
                if (state is PickCVImageState || state is ClearImageState) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
                // var image = context.read<PickImageCubit>();
                if (state is PickCVImageState) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(context
                              .read<PickImageCubit>()
                              .cvUrl
                              .split('/')
                              .last),
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                context.read<PickImageCubit>().clearCVUrl();
                                // setState(() {});
                              },
                              icon: Icon(
                                Icons.clear,
                                color: MyColors.red,
                              ))
                        ],
                      ),
                    ),
                  );
                }
                if (state is ClearImageState) {
                  return SizedBox();
                }
                return SizedBox();
              }),
              SizedBox(height: 20),
              BlocBuilder<PickImageCubit, InitialImage>(buildWhen: (c, state) {
                if (state is PickCVImageState) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
                var image = context.read<PickImageCubit>();
                return CustomButton(
                  title: "Upload your Existing CV",
                  bgColor: MyColors.white,
                  borderColor: MyColors.blue,
                  fontColor: MyColors.blue,
                  onTap: () {
                    image.getCvImage();
                  },
                );
              }),
              SizedBox(height: 50),
              BlocConsumer<AuthCubit, AuthInitialState>(
                  listener: (context, state) {
                print("**************************** $state");
                if (state is ErrorState) {
                  showToast(state.error);
                }
                if (state is CodeSentState) {
                  AppRoutes.push(context, VerifyCodeScreen());
                }
              }, builder: (context, state) {
                var authData = context.read<AuthCubit>();
                var image = context.read<PickImageCubit>();
                return CustomIconButton(
                  image: MyImages.arrowWhite,
                  title: "Continue",
                  backgroundColor: MyColors.blue,
                  fontColor: MyColors.white,
                  borderColor: MyColors.blue,
                  iconColor: MyColors.white,
                  loading: state is AuthLoadingState ? true : false,
                  onclick: () {
                    if (phone.text.isEmpty ||
                        selectedDate.isEmpty ||
                        image.imgUrl.isEmpty ||
                        image.cvUrl.isEmpty) {
                      showToast("Please fill all details");
                    } else {
                      if (isValid) {
                        authData.dob = selectedDate;
                        authData.phoneNumber = phone.text;
                        authData.profilePic = image.imgUrl;
                        authData.cv = image.cvUrl;
                        authData.getData();
                        authData.checkPhoneNumber(context);
                      } else {
                        showToast("Please enter valid number");
                      }
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  String selectedDate = userType == "user" ? "" : "${DateTime.now()}";

  chooseDate(context) async {
    DateTime date = DateTime.now();
    date = await selectDate(context, date);
    selectedDate = DateFormat('dd-MM-yyyy').format(date);
    print(" //////// $selectedDate");
    setState(() {});
  }
}

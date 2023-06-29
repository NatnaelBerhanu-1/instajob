// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/bloc/location_cubit/location_cubit.dart';
import 'package:insta_job/bloc/location_cubit/location_state.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/search_company.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../bloc/bottom_bloc/bottom_bloc.dart';
import '../bottom_navigation_screen.dart';

class AddNewCompany extends StatefulWidget {
  const AddNewCompany({Key? key}) : super(key: key);

  @override
  State<AddNewCompany> createState() => _AddNewCompanyState();
}

class _AddNewCompanyState extends State<AddNewCompany> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String latitude = "";
  String longitude = "";
  String placeId = "";
  bool suggestionVal = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  // void dispose() {
  //   var image = context.read<PickImageCubit>();
  //   image.clearImgUrl();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var image = context.read<PickImageCubit>();
        var locationData = context.read<LocationCubit>();
        image.clearImgUrl();
        locationData.clearAddress();
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            leadingImage: MyImages.backArrowBorder,
            imageColor: MyColors.blue,
            height: 28,
            width: 28,
            title: "",
            onTap: () {
              var image = context.read<PickImageCubit>();
              image.clearImgUrl();
              var locationData = context.read<LocationCubit>();
              locationData.clearAddress();
              context
                  .read<BottomBloc>()
                  .add(SetScreenEvent(false, screenName: BottomNavScreen()));
            },
          ),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Column(
                children: [
                  Center(child: Image.asset(MyImages.resume)),
                  SizedBox(height: 30),
                  CommonText(
                    text: "Add Clients Information",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  SizedBox(height: 30),
                  IconTextField(
                    controller: name,
                    validator: (val) =>
                        requiredValidation(val!, "Company name"),
                    prefixIcon: ImageButton(
                      image: MyImages.userFilled,
                      padding: EdgeInsets.all(14),
                      height: 10,
                      width: 10,
                    ),
                    // suffixIcon: ImageButton(image: MyImages.verified),
                    hint: "Company Name",
                    onChanged: (val) {
                      if (!formKey.currentState!.validate()) {
                        requiredValidation(val!, "Company name");
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  BlocBuilder<LocationCubit, LocationInitial>(
                      builder: (context, state) {
                    var data = context.read<LocationCubit>();
                    return IconTextField(
                      controller: address,
                      prefixIcon: Icon(Icons.location_on_outlined,
                          size: 25, color: MyColors.blue),
                      hint: data.address.isEmpty
                          ? "Search Address"
                          : data.address,
                      readOnly: true,
                      hintColor: data.address.isEmpty
                          ? MyColors.userFont
                          : MyColors.black,
                      onPressed: () {
                        AppRoutes.push(context, SearchCompany(isAddress: true));
                      },
                    );
                  }),
                  SizedBox(height: 20),
                  uploadPhotoCard(context, isSuggestion: suggestionVal),
                  SizedBox(height: 20),
                  BlocConsumer<CompanyBloc, CompanyState>(listener: (c, state) {
                    if (state is ErrorState) {
                      showToast(state.error);
                    }
                  }, builder: (context, snapshot) {
                    var image = context.read<PickImageCubit>();
                    var locationData = context.read<LocationCubit>();
                    return CustomButton(
                      title: "Submit",
                      onTap: () {
                        print("LATITUDE ${locationData.location.latitude}");
                        print("LONGITUDE ${locationData.location.longitude}");
                        // context.read<LocationCubit>().location.lat;
                        if (formKey.currentState!.validate()) {
                          if (image.imgUrl.isNotEmpty) {
                            context.read<CompanyBloc>().add(AddCompanyEvent(
                                  companyName: name.text,
                                  photo: image.imgUrl,
                                  address: locationData.address,
                                  lat:
                                      locationData.location.latitude.toString(),
                                  lang: locationData.location.longitude
                                      .toString(),
                                ));
                            context.read<BottomBloc>().add(SetScreenEvent(false,
                                screenName: BottomNavScreen()));
                            image.clearImgUrl();
                            locationData.clearAddress();
                          } else {
                            showToast("Please choose image");
                          }
                        }
                      },
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

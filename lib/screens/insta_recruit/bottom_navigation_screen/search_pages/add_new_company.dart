// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_state.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/end_points.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppBar(
          leadingImage: MyImages.backArrowBorder,
          title: "",
          onTap: () {
            context
                .read<BottomBloc>()
                .add(SetScreenEvent(false, screenName: BottomNavScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Column(
            children: [
              Center(child: Image.asset(MyImages.resume)),
              SizedBox(height: 30),
              CommonText(
                text: "Add Clients Information",
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 30),
              BlocConsumer<ValidationCubit, InitialValidation>(
                  listener: (c, state) {
                if (state is RequiredValidation) {
                  showToast(state.require);
                }
              }, builder: (context, state) {
                var validate = context.read<ValidationCubit>();
                return IconTextField(
                  controller: name,
                  validator: (val) =>
                      validate.requiredValidation(val!, "Company name"),
                  prefixIcon: ImageButton(image: MyImages.userFilled),
                  // suffixIcon: ImageButton(image: MyImages.verified),
                  hint: "Company Name",
                );
              }),
              SizedBox(height: 30),
              BlocBuilder<PickImageCubit, InitialImage>(
                  builder: (context, state) {
                if (state is PickImageState) {
                  return Image.network("${EndPoint.imageBaseUrl}${state.url}");
                }
                return uploadPhotoCard(context);
              }),
              SizedBox(height: 30),
              BlocConsumer<CompanyBloc, CompanyState>(listener: (c, state) {
                if (state is ErrorState) {
                  showToast(state.error);
                }
              }, builder: (context, snapshot) {
                var image = context.read<PickImageCubit>();
                return CustomButton(
                  title: "Submit",
                  onTap: () {
                    context.read<CompanyBloc>().add(AddCompanyEvent(
                        companyName: name.text, photo: image.imgUrl));
                    context.read<BottomBloc>().add(
                        SetScreenEvent(false, screenName: BottomNavScreen()));
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bottom_sheet/bottom_sheet.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_opening_page.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../custom_button/custom_img_button.dart';

class AssignCompaniesTile extends StatelessWidget {
  final CompanyModel? companyModel;

  const AssignCompaniesTile({super.key, this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.grey.withOpacity(.15)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.10),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(2, 3))
          ]),
      child: ListTile(
        onTap: () {
          // AppRoutes.push(context, TranscriptionScreen());
          print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& ${companyModel?.id}");
          context
              .read<JobPositionBloc>()
              .add(LoadJobPosListEvent(companyId: companyModel!.id.toString()));
          context.read<BottomBloc>().add(SetScreenEvent(true,
              screenName: JobOpeningScreen(companyModel: companyModel)));
        },
        shape: RoundedRectangleBorder(
            side: BorderSide(color: MyColors.grey),
            borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(6),
        tileColor: MyColors.white,
        leading: ImageButton(
          // image: "${EndPoint.imageBaseUrl}${companyModel?.uploadPhoto}",
          image: MyImages.businessAndTrade,
        ),
        title: Text(
          "${companyModel?.companyName}",
          style: TextStyle(
            fontSize: 16,
            color: MyColors.lightBlack,
            overflow: TextOverflow.clip,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: ImageButton(
          padding: EdgeInsets.only(right: 0),
          image: MyImages.rightArrow,
          color: MyColors.blue,
          height: 13,
        ),
      ),
    );
  }
}

Widget uploadPhotoCard(BuildContext context,
    {bool isUpdate = false, String? url, bool isSuggestion = false}) {
  return BlocConsumer<PickImageCubit, InitialImage>(buildWhen: (c, state) {
    if (state is PickImageState) {
      return true;
    }
    return false;
  }, listener: (c, state) {
    if (state is ImageErrorState) {
      showToast(state.imageError);
    }
  }, builder: (context, state) {
    // if (state is PickImageState) {
    //   return Image.network("${EndPoint.imageBaseUrl}${state.url}");
    // }
    return CustomCommonCard(
      onTap: () {
        choosePhoto(context);
      },
      bgColor: MyColors.blue.withOpacity(.10),
      borderRadius: BorderRadius.circular(10),
      borderColor: MyColors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45),
        child: isUpdate
            ? state is PickImageState
                ? Image.network("${EndPoint.imageBaseUrl}${state.url}",
                    fit: BoxFit.cover)
                : Image.network("${EndPoint.imageBaseUrl}$url",
                    fit: BoxFit.cover)
            : state is PickImageState
                ? Image.network("${EndPoint.imageBaseUrl}${state.url}",
                    fit: BoxFit.cover)
                : state is LoadingImageState
                    ? Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageButton(
                            image: MyImages.upload,
                          ),
                          CommonText(
                            text: "Upload Photo",
                            fontColor: MyColors.blue,
                          )
                        ],
                      ),
      ),
    );
  });
}

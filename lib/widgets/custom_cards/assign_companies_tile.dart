// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insta_job/bottom_sheet/bottom_sheet.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:provider/provider.dart';

import '../../bloc/bottom_bloc/bottom_bloc.dart';
import '../../screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_opening_page.dart';
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
          context
              .read<BottomBloc>()
              .add(SetScreenEvent(true, screenName: JobOpeningScreen()));
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

Widget uploadPhotoCard(BuildContext context) {
  return CustomCommonCard(
    onTap: () {
      choosePhoto(context);
    },
    bgColor: MyColors.blue.withOpacity(.10),
    borderRadius: BorderRadius.circular(10),
    borderColor: MyColors.lightBlue,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 45),
      child: Row(
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
}

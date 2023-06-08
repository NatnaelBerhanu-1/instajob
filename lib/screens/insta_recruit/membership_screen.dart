// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/screens/insta_job_user/turn_on_notification_page.dart';
import 'package:insta_job/widgets/custom_button/custom_all_small_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/my_colors.dart';
import '../../../utils/my_images.dart';
import '../../../widgets/custom_button/custom_btn.dart';
import '../../../widgets/custom_cards/custom_common_card.dart';
import '../../utils/app_routes.dart';

class MemberShipScreen extends StatefulWidget {
  final bool isAgreement;
  final bool isRegister;
  const MemberShipScreen(
      {Key? key, this.isAgreement = false, this.isRegister = false})
      : super(key: key);

  @override
  State<MemberShipScreen> createState() => _MemberShipScreenState();
}

class _MemberShipScreenState extends State<MemberShipScreen> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Column(
        children: [
          Expanded(
            flex: 0,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      MyImages.bgCurve,
                      color: MyColors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Row(
                          children: [
                            widget.isRegister
                                ? IconButton(
                                    onPressed: () {
                                      AppRoutes.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      size: 18,
                                      color: MyColors.white,
                                    ))
                                : Spacer(),
                            Spacer(),
                            Column(
                              children: [
                                Image.asset(
                                  MyImages.instaLogo_,
                                  color: MyColors.white,
                                ),
                                CommonText(
                                  text: "Employ instantly",
                                  fontColor: MyColors.white,
                                ),
                              ],
                            ),
                            Spacer(),
                            Spacer(),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Membership",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Agreement",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
                      style: TextStyle(color: MyColors.greyTxt),
                    ),
                    Text(
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nctsi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure ",
                      style: TextStyle(color: MyColors.greyTxt),
                    ),
                    SizedBox(height: 20),
                    widget.isAgreement
                        ? Column(
                            children: [
                              CustomCheckbox(
                                onchanged: (val) {
                                  isCheck = val!;
                                  setState(() {});
                                },
                                value: isCheck,
                                title: Text(
                                  "Click here to agree to all terms and service",
                                  style: TextStyle(
                                      fontSize: 13, color: MyColors.lightBlack),
                                ),
                              ),
                              SizedBox(height: 15),
                              CustomIconButton(
                                image: MyImages.arrowWhite,
                                title: "Continue",
                                backgroundColor: isCheck
                                    ? MyColors.blue
                                    : MyColors.lightBlue,
                                fontColor: MyColors.white,
                                iconColor: MyColors.white,
                                onclick: () async {
                                  context.read<PickImageCubit>().clearImgUrl();
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  if (isCheck) {
                                    AppRoutes.pushAndRemoveUntil(
                                        context, TurnOnNotification());
                                  }
                                  pref.setBool('isAgree', true);
                                },
                              ),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

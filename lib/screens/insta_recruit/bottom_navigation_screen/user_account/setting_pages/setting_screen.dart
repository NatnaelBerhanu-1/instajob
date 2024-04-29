// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/auth_screen/change_account_info.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/setting_pages/save_card_screen.dart';
import 'package:insta_job/screens/insta_recruit/membership_screen.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_cards/setting_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/app_routes.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../widgets/custom_button/custom_btn.dart';
import 'aboutUs_screen.dart';

class SettingScreen extends StatefulWidget {
  // final bool isUserInterface;
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Settings",
              leadingImage: MyImages.arrowBlueLeft,
              height: 17,
              width: 17,
              actions: Global.userModel?.uploadPhoto == null
                  ? SizedBox()
                  : Padding(
                      padding:
                          const EdgeInsets.only(top: 5.0, right: 10, bottom: 5),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${EndPoint.imageBaseUrl}${Global.userModel?.uploadPhoto}"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SettingTile(
                onTap: () {
                  AppRoutes.push(context, AboutUsScreen());
                },
                leadingImage: MyImages.about,
                title: "About Us",
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {
                  AppRoutes.push(context,
                      MemberShipScreen(isAgreement: false, isRegister: true));
                },
                leadingImage: MyImages.membership,
                title: "Membership Agreement",
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {
                  // if (Global.userModel?.type == "user") {
                  //   AppRoutes.push(context,
                  //       ChangeAccInfoScreen(isUpdate: true));
                  // } else {
                  //   AppRoutes.push(context,
                  //       BecameAnEmployer(isUpdate: true));
                  // }
                  AppRoutes.push(context, ChangeAccInfoScreen());
                },
                leadingImage: MyImages.user,
                title: "Change Account Information",
              ),
              // SizedBox(height: 10),
              // Global.userModel?.type == "user"
              //     ? SizedBox()
              //     : SettingTile(
              //         onTap: () {
              //           AppRoutes.push(context, SaveCardScreen());
              //         },
              //         leadingImage: MyImages.visaCardBlue,
              //         title: "Saved Cards",
              //       ),
              // SizedBox(height: 10),
              // Global.userModel?.type == "user"
              //     ? SizedBox()
              //     : SettingTile(
              //         onTap: () {
              //           buildDialog(context, CustomDialog());
              //         },
              //         leadingImage: MyImages.cancelSub,
              //         title: "Cancel Subscription",
              //       ),
              Spacer(),
              BlocConsumer<AuthCubit, AuthInitialState>(
                  listener: (context, state) {
                if (state is ErrorState) {
                  showToast(state.error);
                }
              }, builder: (context, snapshot) {
                return CustomIconButton(
                  image: MyImages.logout,
                  title: "Log Out",
                  loading: snapshot is AuthLoadingState,
                  backgroundColor: MyColors.darkRed,
                  fontColor: MyColors.white,
                  onclick: () {
                    buildDialog(
                        context,
                        CustomDialog(
                          okOnTap: () async {
                            Navigator.of(context)
                                .pop(); //revisit, double check that it's ok to pop first and call other items below(whether everything gets executed, whether to remote the setState etc/ consider dispose method too)
                            context.read<AuthCubit>().logOut();
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            var type = pref.getString("type");
                            userType = type ?? "";
                            setState(() {});
                            print("TYPEEEEEEEE  $type");
                            print("TYPEEEEEEEE USER   $userType");
                          },
                          cancelOnTap: () {
                            Navigator.pop(context);
                          },
                        ));
                  },
                );
              }),
              SizedBox(height: 10),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/setting_pages/add_card_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/subscribe_pages/congratulation_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_cards/payment_tile.dart';

import '../../../../../bloc/global_cubit/global_state.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../widgets/custom_button/custom_btn.dart';

class SaveCardScreen extends StatefulWidget {
  final bool isChoosePayment;
  const SaveCardScreen({Key? key, this.isChoosePayment = false}) : super(key: key);

  @override
  State<SaveCardScreen> createState() => _SaveCardScreenState();
}

class _SaveCardScreenState extends State<SaveCardScreen> {
  int sIndex = 0;
  int sqIndex = 0;
  @override
  Widget build(BuildContext context) {
    var selectedIndex = context.watch<GlobalCubit>().sIndex;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: widget.isChoosePayment ? "Choose Payment Option" : "Saved Cards",
              leadingImage: MyImages.arrowBlueLeft,
              onTap: () {
                // AppRoutes.push(context, JobBoardsScreen());
                AppRoutes.pop(context);
              },
              height: 17,
              width: 17,
              actions: widget.isChoosePayment
                  ? SizedBox()
                  : IconButton(
                      visualDensity: VisualDensity.standard,
                      splashColor: MyColors.transparent,
                      onPressed: () {
                        buildDialog(
                            context,
                            CustomDialog(
                              desc1: "You want to delete card",
                            ));
                      },
                      icon: Icon(
                        Icons.delete,
                        color: MyColors.darkRed,
                      )),
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
              return Column(
                children: [
                  PaymentTile(
                    onClick: () {
                      sIndex = 1;
                      context.read<GlobalCubit>().changeIndex(sIndex);
                    },
                    index: 1,
                    selectedIndex: selectedIndex,
                    image: MyImages.visaCardBlue,
                    userName: "Visa - 5072",
                  ),
                  PaymentTile(
                    onClick: () {
                      sIndex = 2;
                      context.read<GlobalCubit>().changeIndex(sIndex);
                    },
                    index: 2,
                    selectedIndex: selectedIndex,
                    image: MyImages.apple,
                    userName: "Apple Pay",
                  ),
                  PaymentTile(
                    onClick: () {
                      sIndex = 3;
                      context.read<GlobalCubit>().changeIndex(sIndex);
                    },
                    index: 3,
                    selectedIndex: selectedIndex,
                    image: MyImages.google,
                    userName: "Google Pay",
                  ),
                  PaymentTile(
                    onClick: () {
                      sIndex = 4;
                      context.read<GlobalCubit>().changeIndex(sIndex);
                    },
                    index: 4,
                    selectedIndex: selectedIndex,
                    image: MyImages.paypal,
                    userName: "Paypal",
                  ),
                  SizedBox(height: 40),
                  DottedButton(
                    onTap: () {
                      AppRoutes.push(context, AddCardScreen());
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.29),
                  // Spacer(),
                  widget.isChoosePayment
                      ? CustomButton(
                          title: "Check Out",
                          onTap: () {
                            AppRoutes.push(context, CongratulationsScreen());
                          },
                        )
                      : SizedBox()
                ],
              );
            }),
          ),
        ));
  }
}

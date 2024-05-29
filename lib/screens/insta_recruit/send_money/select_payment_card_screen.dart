// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/screens/insta_recruit/send_money/add_payment_card_screen.dart';
import 'package:insta_job/screens/insta_recruit/send_money/payment_card_tile.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_images.dart';

import '../../../../../bloc/global_cubit/global_state.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../widgets/custom_button/custom_btn.dart';

class SelectPaymentCardBottomSheetChild extends StatefulWidget {
  final bool isChoosePayment;
  const SelectPaymentCardBottomSheetChild({Key? key, this.isChoosePayment = false}) : super(key: key);

  @override
  State<SelectPaymentCardBottomSheetChild> createState() => _SaveCardScreenState();
}

class _SaveCardScreenState extends State<SelectPaymentCardBottomSheetChild> {
  int sIndex = 0;
  int sqIndex = 0;
  @override
  Widget build(BuildContext context) {
    var selectedIndex = context.watch<GlobalCubit>().sIndex;
    return Container(
      // height: MediaQuery.of(context).size.height * 0.5,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
          return Column(
            children: [
              Text(
                "Choose Payment Method",
                style: TextStyle(
                  fontSize: 18,
                  color: MyColors.black,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 18),
              PaymentCardTile(
                onClick: () {
                  sIndex = 1;
                  context.read<GlobalCubit>().changeIndex(sIndex);
                },
                index: 1,
                selectedIndex: selectedIndex,
                image: MyImages.visaCardBlue,
              ),
              SizedBox(height: 10),
              PaymentCardTile(
                onClick: () {
                  sIndex = 2;
                  context.read<GlobalCubit>().changeIndex(sIndex);
                },
                index: 2,
                selectedIndex: selectedIndex,
                image: MyImages.apple,
              ),
              SizedBox(height: 6),
              InkWell(
                onTap: () {
                  // AppRoutes.push(context, AddPaymentCardBottomSheetChild());
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return Builder(
                        // initialChildSize: 0.75,
                        // maxChildSize: 1,
                        // minChildSize: 0.75,
                        // builder: (BuildContext context, ScrollController scrollController) {
                        builder: (BuildContext context) {
                          return AddPaymentCardBottomSheetChild();
                        }
                      );
                    },
                  );

                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, top: 2, bottom: 2),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: MyColors.blue,
                          size: 28,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Add new card",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            color: MyColors.blue,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14),
              CustomButton(
                title: "Continue",
                onTap: () {
                  // AppRoutes.push(context, CongratulationsScreen());
                  // Navigator.of(context).pop(); //REVISIT this pop
                  AppRoutes.pop(context);
                },
              ),
              SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }
}

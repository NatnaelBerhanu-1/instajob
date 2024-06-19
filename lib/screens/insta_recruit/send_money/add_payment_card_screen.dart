// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../../widgets/custom_button/custom_btn.dart';

class AddPaymentCardBottomSheetChild extends StatefulWidget {
  const AddPaymentCardBottomSheetChild({Key? key}) : super(key: key);

  @override
  State<AddPaymentCardBottomSheetChild> createState() => _AddPaymentCardBottomSheetChildState();
}

class _AddPaymentCardBottomSheetChildState extends State<AddPaymentCardBottomSheetChild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height  * 0.5,
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      child: Column(
        children: [
          Text(
            "Add new card",
            style: TextStyle(
              fontSize: 18,
              color: MyColors.black,
              overflow: TextOverflow.clip,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          SizedBox(height: 28),
          Material(
            elevation: 7,
            shadowColor: MyColors.grey.withOpacity(.14),
            borderRadius: BorderRadius.circular(12),
            child: IconTextField(
              // prefixIcon: ImageButton(
              //   image: MyImages.visaCardBlue,
              //   padding: EdgeInsets.all(14),
              //   height: 10,
              //   width: 10,
              // ),
              hint: "Card Number",
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Material(
                  elevation: 7,
                  shadowColor: MyColors.grey.withOpacity(.14),
                  borderRadius: BorderRadius.circular(12),
                  child: IconTextField(
                    // prefixIcon: ImageButton(
                    //   image: MyImages.cal,
                    //   padding: EdgeInsets.all(14),
                    //   height: 10,
                    //   width: 10,
                    // ),
                    // hint: "05/21",
                    hint: "Expiration date",
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Material(
                  elevation: 7,
                  shadowColor: MyColors.grey.withOpacity(.14),
                  borderRadius: BorderRadius.circular(12),
                  child: CustomTextField(
                    hint: "CVV",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Material(
            elevation: 7,
            shadowColor: MyColors.grey.withOpacity(.14),
            borderRadius: BorderRadius.circular(12),
            child: IconTextField(
              // prefixIcon: ImageButton(
              //   image: MyImages.user,
              //   padding: EdgeInsets.all(14),
              //   height: 10,
              //   width: 10,
              // ),
              hint: "Card Name",
            ),
          ),
          // Spacer(),
          // SizedBox(height: 60),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: CustomButton(
                title: "Save",
                onTap: () {
                  AppRoutes.pop(context);
                  // AppRoutes.push(
                  //     context, SaveCardScreen(isChoosePayment: true));
                },
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

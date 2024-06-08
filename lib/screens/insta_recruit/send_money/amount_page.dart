// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/screens/insta_recruit/send_money/select_payment_card_screen.dart';
import 'package:insta_job/screens/insta_recruit/send_money/verify_money_transfer.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

class PaymentAmountScreen extends StatefulWidget {

  const PaymentAmountScreen(
      {Key? key})
      : super(key: key);

  @override
  State<PaymentAmountScreen> createState() => _PaymentAmountScreenState();
}

class _PaymentAmountScreenState extends State<PaymentAmountScreen> {
  TextEditingController amountSendingController = TextEditingController();
  TextEditingController applicationReceivedContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 90),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6).copyWith(top: 28),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Image.asset(
                        MyImages.backArrow,
                        height: 40,
                        width: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
          .copyWith(top: 0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CircleAvatar(radius: 40),
                SizedBox(height: 16,),
                Text(
                  "Nicholas M.",
                  style: TextStyle(
                    fontSize: 20,
                    color: MyColors.black,
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  "Receives",
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.lightBlack,
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 32,),
                _buildSelectedCard(),
                // _buildAddNewCardButton(),
                const SizedBox(height: 36,),
                CustomMoneyTextField(
                  // controller: amountSendingController,
                  hint: "\$ 00.00",
                  validator: (val) => requiredValidationn(val!),
                  onChanged: (val) {
                    if (val != null && val is String && val.isNotEmpty && val == "\$ ") {
                      amountSendingController.text = "";
                    } else {
                      amountSendingController.text = val;
                    }
                    setState(() {});
                  },
                  inputFormatter: [
                    _CurrencyInputFormatter(),
                  ],
                ),
                const SizedBox(height: 4,),
                CustomTextField(
                  controller: applicationReceivedContent,
                  hint: "Type a message",
                  label: "",
                  maxLine: 5,
                  validator: (val) => requiredValidationn(val!),
                ),
                const SizedBox(height: 32,),
                CustomButton(
                  title: "Send Money",
                  fontColor: MyColors.white,
                  borderColor: MyColors.blue,
                  onTap: () {
                    // AppRoutes.push(context, SendMoneySuccessScreen());
                    AppRoutes.push(context, VerifyMoneyTransferScreen());
                    // AppRoutes.push(context, SaveCardScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedCard() {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.grey.withOpacity(.15)),
          ),
      child: ListTile(
        onTap: () {
        },
        shape: RoundedRectangleBorder(side: BorderSide(color: MyColors.grey), borderRadius: BorderRadius.circular(10)),
        // contentPadding: EdgeInsets.all(6),
        tileColor: MyColors.white,
        // leading: ImageButton(
        //   // image: "${EndPoint.imageBaseUrl}${companyModel?.uploadPhoto}",
        //   image: MyImages.businessAndTrade,
        // ),
        leading: const CircleAvatar(),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                "Nicholas M.",
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.black,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                "***2243",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.lightBlack.withOpacity(0.7),
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ]),
            Spacer(),
            GestureDetector(
              onTap: () {
                // AppRoutes.push(context, VerifyMoneyTransferScreen());
                // AppRoutes.push(context, SelectPaymentCardScreen());
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  // isDismissible: true,  
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
                        return SafeArea(child: SelectPaymentCardBottomSheetChild());
                      }
                    );
                  },
                );

              },
              child: Row(
                children: [
                  Text(
                    "CHANGE",
                    style: TextStyle(
                      fontSize: 14,
                      color: MyColors.lightBlue.withOpacity(0.7),
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ImageButton(
                    padding: EdgeInsets.only(right: 10),
                    image: MyImages.arrowWhite,
                    color: MyColors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewCardButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.grey.withOpacity(.15)),
          ),
      child: ListTile(
        onTap: () {
        },
        shape: RoundedRectangleBorder(side: BorderSide(color: MyColors.grey), borderRadius: BorderRadius.circular(10)),
        tileColor: MyColors.blue.withOpacity(0.9),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: MyColors.white,
            ),
            SizedBox(width: 2),
            Text(
              "Add new card",
              style: TextStyle(
                fontSize: 16,
                color: MyColors.white,
                overflow: TextOverflow.clip,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    newValue.text.replaceAll('\$ ', '');
    if (newValue.text.isEmpty) {
      // return newValue.copyWith(text: '\$ ');
      return newValue;
    }
    if (!newValue.text.startsWith('\$ ')) {
      final newText = '\$ ${newValue.text.replaceAll(RegExp(r'\D'), '')}';
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    return newValue;
  }
}
import 'package:flutter/material.dart';
import 'package:insta_job/screens/insta_recruit/send_money/payment_card_tile.dart';
import 'package:insta_job/screens/insta_recruit/send_money/send_money_bottom_sheet_child.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';

class SendMoneySuccessScreen2 extends StatefulWidget {
  const SendMoneySuccessScreen2(
      {Key? key})
      : super(key: key);

  @override
  State<SendMoneySuccessScreen2> createState() => _SendMoneySuccessScreen2State();
}

class _SendMoneySuccessScreen2State extends State<SendMoneySuccessScreen2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.64,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
          .copyWith(top: 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16,),
            const TransactionTile(showDate: false,),
            const SizedBox(height: 16,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Status",
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.lightBlack.withOpacity(0.7),
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.1,
                  ),
                ),
            ),
            const SizedBox(height: 8,),
            Row(children: [
              Image.asset(
                MyImages.verified,
                height: 22,
                width: 22,
              ),
              const SizedBox(width: 4),
              Text(
                "Successful",
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.black,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),

            ],),
            const SizedBox(height: 22),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Date",
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.lightBlack.withOpacity(0.7),
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.1,
                  ),
                ),
            ),
            const SizedBox(height: 8,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Dec 22, 2023 at 7:30 PM",
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.black,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            const SizedBox(height: 22),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Payment Method",
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.lightBlack.withOpacity(0.7),
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.1,
                  ),
                ),
            ),
            const SizedBox(height: 8,),
            PaymentCardTile(
              onClick: () {
                // sIndex = 1;
                // context.read<GlobalCubit>().changeIndex(sIndex);
              },
              isSelectMode: false,
              index: 1,
              // selectedIndex: selectedIndex,
              image: MyImages.visaCardBlue,
            ),
            const SizedBox(height: 14),
            CustomButton(
              bgColor: MyColors.blue.withOpacity(0.7),
              title: "Invoice",
              onTap: () {
              },
            ),
            
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

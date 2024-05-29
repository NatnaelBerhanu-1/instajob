import 'package:flutter/material.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';

class SendMoneySuccessScreen extends StatefulWidget {

  const SendMoneySuccessScreen(
      {Key? key})
      : super(key: key);

  @override
  State<SendMoneySuccessScreen> createState() => _SendMoneySuccessScreenState();
}

class _SendMoneySuccessScreenState extends State<SendMoneySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 90),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Image.asset(
              MyImages.verified,
              height: 40,
              width: 40,
            ),
            const SizedBox(height: 20,),
            Text(
              "Success!",
              style: TextStyle(
                fontSize: 20,
                color: MyColors.black,
                overflow: TextOverflow.clip,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 14,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                "Your payment has been successfully sent!",
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.lightBlack,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

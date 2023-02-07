// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/payment_tile.dart';

import '../../../utils/my_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button/custom_btn.dart';

class SaveCardScreen extends StatefulWidget {
  const SaveCardScreen({Key? key}) : super(key: key);

  @override
  State<SaveCardScreen> createState() => _SaveCardScreenState();
}

class _SaveCardScreenState extends State<SaveCardScreen> {
  int sIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Save Cards",
              leadingImage: MyImages.arrowBlueLeft,
              height: 17,
              width: 17,
              actions: IconButton(
                  visualDensity: VisualDensity.standard,
                  splashColor: MyColors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: MyColors.red,
                  )),
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                PaymentTile(
                  onClick: () {
                    sIndex = 1;
                    setState(() {});
                  },
                  index: 1,
                  selectedIndex: sIndex,
                  image: MyImages.visaCardBlue,
                  userName: "Visa - 5072",
                ),
                PaymentTile(
                  onClick: () {
                    sIndex = 2;
                    setState(() {});
                  },
                  index: 2,
                  selectedIndex: sIndex,
                  image: MyImages.apple,
                  userName: "Apple Pay",
                ),
                PaymentTile(
                  onClick: () {
                    sIndex = 3;
                    setState(() {});
                  },
                  index: 3,
                  selectedIndex: sIndex,
                  image: MyImages.google,
                  userName: "Google Pay",
                ),
                PaymentTile(
                  onClick: () {
                    sIndex = 4;
                    setState(() {});
                  },
                  index: 4,
                  selectedIndex: sIndex,
                  image: MyImages.paypal,
                  userName: "Paypal",
                ),
                SizedBox(height: 40),
                DottedButton()
              ],
            ),
          ),
        ));
  }
}

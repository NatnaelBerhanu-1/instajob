// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';

import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_images.dart';
import '../../../../../widgets/custom_cards/custom_common_card.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

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
                        child: Column(
                          children: [
                            Image.asset(
                              MyImages.instaLogo_,
                              color: MyColors.white,
                            ),
                            CommonText(
                              text: "Employee instantly",
                              fontColor: MyColors.white,
                            ),
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
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                        style: ButtonStyle(overlayColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return MyColors.transparent;
                          }
                          return MyColors.blue;
                        })),
                        onPressed: () {},
                        icon: ImageButton(
                          padding: EdgeInsets.zero,
                          image: MyImages.phone,
                        ),
                        label: Text(
                          '+91 9344321876',
                          style: TextStyle(
                              color: MyColors.black,
                              fontWeight: FontWeight.w400),
                        )),
                    TextButton.icon(
                        style: ButtonStyle(overlayColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return MyColors.transparent;
                          }
                          return MyColors.blue;
                        })),
                        onPressed: () {},
                        icon: ImageButton(
                          image: MyImages.phone,
                          padding: EdgeInsets.zero,
                        ),
                        label: Text(
                          'lweeway@protonmail.com',
                          style: TextStyle(
                              color: MyColors.black,
                              fontWeight: FontWeight.w400),
                        )),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About Us",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                              "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
                          Text(
                              "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nctsi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure "),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
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

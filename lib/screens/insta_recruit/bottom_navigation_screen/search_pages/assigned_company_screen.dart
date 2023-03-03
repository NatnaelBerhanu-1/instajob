// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:insta_job/provider/bottom_provider.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/add_new_company.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AssignCompany extends StatelessWidget {
  const AssignCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            leadingImage: "",
            title: "Assign Companies",
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 0,
              child: Container(
                color: MyColors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hint: "Search Companies",
                        ),
                      ),
                      SizedBox(width: 22),
                      Expanded(
                          flex: 0,
                          child: CustomCommonCard(
                            onTap: () {
                              context.read<BottomProvider>().setSelectedScreen(
                                  true,
                                  screenName: AddNewCompany());
                              // AppRoutes.push(context, AddNewCompany());
                            },
                            borderRadius: BorderRadius.circular(40),
                            bgColor: MyColors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Icon(
                                Icons.add,
                                color: MyColors.white,
                              ),
                            ),
                          )
                          // FloatingActionButton(
                          //   backgroundColor: MyColors.blue,
                          //   elevation: 0,
                          //   onPressed: () {},
                          //   child: Icon(Icons.add),
                          // ),
                          )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (c, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 12),
                        child: AssignCompaniesTile(
                          leadingImage: MyImages.businessAndTrade,
                          title: "Burger 1",
                        ),
                      );
                    }))
          ],
        ));
  }
}

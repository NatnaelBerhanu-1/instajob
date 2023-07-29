// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_bloc.dart';
import 'package:insta_job/bloc/career_learning_bloc/career_learning_state.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/cluster_widget/custom_career_tile.dart';

import '../../widgets/custom_app_bar.dart';

class CareerClusterScreen extends StatelessWidget {
  const CareerClusterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Browse by career cluster",
              onTap: () {
                context.read<CareerLearningBloc>().clearValue();
                Navigator.pop(context);
              },
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          child: Column(
            children: [
              BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                  builder: (context, state) {
                var careerValue = context.read<CareerLearningBloc>();
                return CustomCommonCard(
                  borderRadius: BorderRadius.circular(30),
                  borderColor: MyColors.lightgrey,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        // style: TextStyle(color: MyColors.black),
                        padding: EdgeInsets.only(left: 12),
                        items: careerValue.list
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.title.toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ))
                            .toList(),
                        isExpanded: true,
                        hint: Text(
                          "Browse by career cluster",
                          style: TextStyle(color: MyColors.grey, fontSize: 14),
                        ),
                        icon: Row(
                          children: [
                            Icon(Icons.keyboard_arrow_down,
                                color: MyColors.grey),
                            SizedBox(width: 4),
                            CustomCommonCard(
                              bgColor: MyColors.blue,
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: CommonText(
                                  text: "Go",
                                  fontColor: MyColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        value: careerValue.dropDownValue,
                        onChanged: (val) {
                          careerValue.changeDropDownValue(val);
                          careerValue.getClusterDetailList(code: val?.code);
                          print(careerValue.dropDownValue);
                        },
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<CareerLearningBloc, InitialCareerLearning>(
                    builder: (context, state) {
                  var careerValue = context.read<CareerLearningBloc>();
                  return state is CareerLeaningLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: careerValue.careerDetailList.length,
                          itemBuilder: (c, i) {
                            return CustomCareerTile(
                              clusterDetailsModel:
                                  careerValue.careerDetailList[i],
                            );
                          });
                }),
              )
            ],
          ),
        ));
  }
}

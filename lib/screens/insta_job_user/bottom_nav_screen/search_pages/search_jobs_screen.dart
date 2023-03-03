// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_bloc.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/filter_tiles/custom_filter_tile.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/map_tile.dart';

import '../../../../utils/my_colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_button/custom_img_button.dart';
import '../../../../widgets/custom_cards/assign_companies_tile.dart';
import '../../../../widgets/custom_cards/insta_job_user_cards/search_job_tile.dart';
import '../../../../widgets/custom_chip.dart';
import '../../../insta_recruit/bottom_navigation_screen/user_account/setting_pages/save_card_screen.dart';
import 'filter_screen.dart';

class SearchJobsScreen extends StatefulWidget {
  const SearchJobsScreen({Key? key}) : super(key: key);

  @override
  State<SearchJobsScreen> createState() => _SearchJobsScreenState();
}

class _SearchJobsScreenState extends State<SearchJobsScreen> {
  // int filterIndex = 0;
  // int searchIndex = 1;
  @override
  Widget build(BuildContext context) {
    var selectedFilterIndex = context.watch<IndexBloc>().fIndex;
    var selectedSearchIndex = context.watch<IndexBloc>().sIndex;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Search Jobs",
              centerTitle: false,
              leadingImage: "",
              leadingWidth: 5,
              actions: ImageButton(
                image: MyImages.searchBlue,
                padding: EdgeInsets.only(left: 10, right: 20),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            color: MyColors.white,
            child:
                BlocBuilder<IndexBloc, InitialState>(builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            height: 40,
                            // width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: MyColors.blue),
                                color: MyColors.white),
                            child: Row(
                              children: List.generate(
                                  list.length,
                                  (index) => Expanded(
                                        child: Container(
                                          height: 40,
                                          // width: MediaQuery.of(context).size.width - 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                  color: MyColors.white),
                                              color: MyColors.white),
                                          child: CustomFilterTile(
                                            onClick: () {
                                              // filterIndex = index;
                                              context
                                                  .read<IndexBloc>()
                                                  .changeFilterIndex(index);
                                            },
                                            selectedIndex: selectedFilterIndex,
                                            index: index,
                                            title: list[index],
                                          ),
                                        ),
                                      )),
                            )),
                      ),
                      SizedBox(width: 7),
                      Expanded(
                          flex: 0,
                          child: GestureDetector(
                            onTap: () {
                              AppRoutes.push(context, FilterScreen());
                            },
                            child: Container(
                              color: MyColors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  MyImages.filter,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  if (selectedFilterIndex == 0) ...[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 0,
                                  child: CustomSearchChip(
                                    onTap: () {
                                      context.read<IndexBloc>().changeIndex(1);
                                    },
                                    image: MyImages.suitcase,
                                    index: 1,
                                    selectedIndex: selectedSearchIndex,
                                    title: "Search Jobs",
                                  )),
                              SizedBox(width: 15),
                              Expanded(
                                  child: CustomSearchChip(
                                onTap: () {
                                  context.read<IndexBloc>().changeIndex(2);
                                },
                                index: 2,
                                selectedIndex: selectedSearchIndex,
                                title: "Search Companies",
                              )),
                            ],
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 7,
                                itemBuilder: (c, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 5),
                                    child: selectedSearchIndex == 1
                                        ? SearchJobTile()
                                        : AssignCompaniesTile(
                                            leadingImage:
                                                MyImages.businessAndTrade,
                                            title: "Ford",
                                          ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ] else if (selectedFilterIndex == 1 ||
                      selectedFilterIndex == 2) ...[
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Slider(
                            value: 10,
                            onChanged: (val) {},
                            max: 80,
                            min: 10,
                          ),
                          Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.74,
                                color: MyColors.grey,
                              ),
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: 10,
                                      itemBuilder: (c, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 10),
                                          child: MapTile(),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                  ] else
                    ...[],
                ],
              );
            }),
          ),
        ));
  }
}

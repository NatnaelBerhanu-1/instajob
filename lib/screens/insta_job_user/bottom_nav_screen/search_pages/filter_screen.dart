// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/model/filter_model.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/add_job_position_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/filter_tiles/custom_filter_card.dart';

import '../../../../widgets/custom_divider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  SalariesOptionChosen salariesOptionChosen = SalariesOptionChosen.allSalaries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
                title: "Filters",
                centerTitle: false,
                leadingWidth: 6,
                toolbarHeight: 45,
                actions: Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 10),
                  child: CustomCommonCard(
                    onTap: () {
                      Navigator.of(context).pop();
                      context.read<GlobalCubit>().clearValue();
                    },
                    borderColor: MyColors.blue,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 13, color: MyColors.blue),
                      ),
                    ),
                  ),
                ))),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
                var value = context.read<GlobalCubit>();
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: "Sort By"),
                      SizedBox(height: 7),
                      CustomCommonCard(
                        borderColor: MyColors.grey.withOpacity(.30),
                        borderRadius: BorderRadius.circular(7),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              jobTypeTile(
                                title: "Sort By Relevance",
                                value: value.sortByValue,
                                selectedValue: "Sort By Relevance",
                                onTap: () {
                                  value.sortBy("Sort By Relevance");
                                },
                              ),
                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Sort By Date",
                                value: value.sortByValue,
                                selectedValue: "Sort By Date",
                                onTap: () {
                                  value.sortBy("Sort By Date");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]);
              }),
              SizedBox(height: 20),
              BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
                var value = context.read<GlobalCubit>();
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: "Duration"),
                      SizedBox(height: 7),
                      CustomCommonCard(
                        borderColor: MyColors.grey.withOpacity(.30),
                        borderRadius: BorderRadius.circular(7),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // jobTypeTile(
                              //   title: "All Jobs",
                              //   value: 1.toString(),
                              //   selectedValue: value.durationIndex.toString(),
                              //   onTap: () {
                              //     value.duration("All Jobs");
                              //     value.durationIndexChange(1);
                              //   },
                              // ),
                              // divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Last 24 Hours",
                                value: 1.toString(),
                                selectedValue: value.durationIndex.toString(),
                                onTap: () {
                                  value.last24Duration("Last 24 Hours");
                                  value.durationIndexChange(1);
                                },
                              ),
                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Last 3 Days",
                                value: 2.toString(),
                                selectedValue: value.durationIndex.toString(),
                                onTap: () {
                                  value.last3Duration("Last 3 Days");
                                  value.durationIndexChange(2);
                                },
                              ),
                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Last 7 Days",
                                value: 3.toString(),
                                selectedValue: value.durationIndex.toString(),
                                onTap: () {
                                  value.last7Duration("Last 7 Days");
                                  value.durationIndexChange(3);
                                },
                              ),
                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "Last 14 Days",
                                value: 4.toString(),
                                selectedValue: value.durationIndex.toString(),
                                onTap: () {
                                  value.last14Duration("Last 14 Days");
                                  value.durationIndexChange(4);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]);
              }),
              SizedBox(height: 20),
              BlocBuilder<GlobalCubit, InitialState>(
                  builder: (context, state) {
                var values = context.read<GlobalCubit>();
                return CustomCommonCard(
                  borderColor: MyColors.grey.withOpacity(.30),
                  borderRadius: BorderRadius.circular(7),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              salariesOptionChosen =
                                  SalariesOptionChosen.allSalaries;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText(
                                  text: "All Salaries",
                                  fontSize: 12,
                                  fontColor: salariesOptionChosen ==
                                          SalariesOptionChosen
                                              .allSalaries
                                      ? MyColors.blue
                                      : MyColors.grey,
                                ),
                                if (salariesOptionChosen ==
                                    SalariesOptionChosen.allSalaries)
                                  ImageButton(
                                    image: MyImages.verified,
                                    padding: EdgeInsets.zero,
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: divider(color: MyColors.grey.withOpacity(.40)),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            salariesOptionChosen =
                                SalariesOptionChosen.customRange;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonText(
                                    text: "Custom Range",
                                    fontSize: 14,
                                    fontColor: salariesOptionChosen ==
                                            SalariesOptionChosen.customRange
                                        ? MyColors.blue
                                        : MyColors.grey,
                                  ),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        CommonText(
                                          text:
                                              "${values.rangeValue.start.toStringAsFixed(0)}k - ${values.rangeValue.end.toStringAsFixed(0)}k",
                                          fontSize: 14,
                                          fontColor: MyColors.grey,
                                        ),
                                        if (salariesOptionChosen ==
                                            SalariesOptionChosen
                                                .customRange)
                                          Row(
                                            children: [
                                              SizedBox(width: 10),
                                              ImageButton(
                                                image: MyImages.verified,
                                                padding: EdgeInsets.zero,
                                              )
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              RangeSlider(
                                values: values.rangeValue,
                                onChanged: salariesOptionChosen ==
                                              SalariesOptionChosen
                                                  .customRange ? (val) {
                                  values.rangeValues(val);
                                }: null,
                                max: 100,
                                min: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 20),
              CommonText(
                text: "Area Distance",
                fontSize: 14,
              ),
              SizedBox(height: 20),
              BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
                var values = context.read<GlobalCubit>();
                return CustomCommonCard(
                  borderColor: MyColors.grey.withOpacity(.30),
                  borderRadius: BorderRadius.circular(7),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text:
                              "With in ${values.range.toStringAsFixed(0)} miles",
                          fontSize: 12,
                          fontColor: MyColors.blue,
                        ),
                        SizedBox(height: 10),
                        divider(color: MyColors.grey.withOpacity(.40)),
                        Slider(
                          value: values.range,
                          onChanged: (val) {
                            values.rangeVal(val);
                          },
                          max: 100,
                          min: 0,
                        )
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 20),
              BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
                var value = context.read<GlobalCubit>();
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: "Jobs"),
                      SizedBox(height: 7),
                      CustomCommonCard(
                        borderColor: MyColors.grey.withOpacity(.30),
                        borderRadius: BorderRadius.circular(7),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              jobTypeTile(
                                title: "InstaJob Only",
                                value: value.jobSourceValue,
                                selectedValue: "InstaJob Only",
                                onTap: () {
                                  value.jobSource("InstaJob Only");
                                },
                              ),
                              divider(color: MyColors.grey.withOpacity(.40)),
                              jobTypeTile(
                                title: "All Jobs",
                                value: value.jobSourceValue,
                                selectedValue: "All Jobs",
                                onTap: () {
                                  value.jobSource("All Jobs");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]);
              }),
              SizedBox(height: 20),
              BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
                var value = context.read<GlobalCubit>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(text: "Job Types"),
                    SizedBox(height: 7),
                    CustomCommonCard(
                      borderColor: MyColors.grey.withOpacity(.30),
                      borderRadius: BorderRadius.circular(7),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            jobTypeTile(
                              title: "Full Time",
                              value: value.jobTypeValue,
                              selectedValue: "Full Time",
                              onTap: () {
                                value.jobType("Full Time");
                              },
                            ),
                            divider(color: MyColors.grey.withOpacity(.40)),
                            jobTypeTile(
                              title: "Part Time",
                              value: value.jobTypeValue,
                              selectedValue: "Part Time",
                              onTap: () {
                                value.jobType("Part Time");
                              },
                            ),
                            divider(color: MyColors.grey.withOpacity(.40)),
                            jobTypeTile(
                              title: "Contact",
                              value: value.jobTypeValue,
                              selectedValue: "Contact",
                              onTap: () {
                                value.jobType("Contact");
                              },
                            ),
                            divider(color: MyColors.grey.withOpacity(.40)),
                            jobTypeTile(
                              title: "Temporary",
                              value: value.jobTypeValue,
                              selectedValue: "Temporary",
                              onTap: () {
                                value.jobType("Temporary");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    CommonText(text: "Experience Level"),
                    SizedBox(height: 7),
                    CustomCommonCard(
                      borderColor: MyColors.grey.withOpacity(.30),
                      borderRadius: BorderRadius.circular(7),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // jobTypeTile(
                            //   title: "All Experience Level",
                            //   value: value.experienceLevelVal,
                            //   selectedValue: "All Experience Level",
                            //   onTap: () {
                            //     value.experienceLevel("All Experience Level");
                            //   },
                            // ),
                            // divider(color: MyColors.grey.withOpacity(.40)),
                            jobTypeTile(
                              title: "Entry Level",
                              value: value.experienceLevelVal,
                              selectedValue: "Entry Level",
                              onTap: () {
                                value.experienceLevel("Entry Level");
                              },
                            ),
                            divider(color: MyColors.grey.withOpacity(.40)),
                            jobTypeTile(
                              title: "Mid Level",
                              value: value.experienceLevelVal,
                              selectedValue: "Mid Level",
                              onTap: () {
                                value.experienceLevel("Mid Level");
                              },
                            ),
                            divider(color: MyColors.grey.withOpacity(.40)),
                            jobTypeTile(
                              title: "Senior Level",
                              value: value.experienceLevelVal,
                              selectedValue: "Senior Level",
                              onTap: () {
                                value.experienceLevel("Senior Level");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 40),
              BlocBuilder<JobPositionBloc, JobPosState>(
                  builder: (context, state) {
                var data = context.read<JobPositionBloc>();
                return CustomIconButton(
                  image: MyImages.arrowWhite,
                  loading: state is JobPosLoading ? true : false,
                  title: "Update Now",
                  onclick: () {
                    var value = context.read<GlobalCubit>();
                    FilterModel filterModel = FilterModel(
                      last24: value.last_24,
                      last14: value.last_14,
                      last7: value.last_7,
                      last3: value.last_3,
                      startSalary: salariesOptionChosen == SalariesOptionChosen.allSalaries
                          ? ""
                          : value.rangeValue.start.toStringAsFixed(0),
                      endSalary: salariesOptionChosen == SalariesOptionChosen.allSalaries
                          ? ""
                          : value.rangeValue.end.toStringAsFixed(0),
                      areaDistance: value.range == 0
                          ? ""
                          : value.range.toStringAsFixed(0),
                      jobsType: value.jobTypeValue,
                      jobsSource: value.jobSourceValue,
                      sortbydate: value.sortByValue,
                      experienceLevel: value.experienceLevelVal,
                    );
                    data.add(JobSearchEvent(filterModel: filterModel));
                    // context.read<JobPositionBloc>().add(LoadJobPosListEvent());
                    Navigator.pop(context);
                    value.clearValue();
                  },
                );
              }),
            ],
          ),
        ));
  }
}

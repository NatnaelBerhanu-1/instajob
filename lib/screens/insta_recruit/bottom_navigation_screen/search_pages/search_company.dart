// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_opening_page.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_position_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/widgets/custom_divider.dart';

import '../../../../bloc/company_bloc/company_bloc.dart';
import '../../../../bloc/company_bloc/company_event.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/my_images.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_button/custom_img_button.dart';
import '../../../../widgets/custom_text_field.dart';

class SearchCompany extends StatefulWidget {
  final int? index;
  final bool isJobSearch;
  const SearchCompany({Key? key, this.index, this.isJobSearch = false})
      : super(key: key);

  @override
  State<SearchCompany> createState() => _SearchCompanyState();
}

class _SearchCompanyState extends State<SearchCompany> {
  final TextEditingController search = TextEditingController();
  // CompanyModel companyData = CompanyModel();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        search.clear();
        FocusManager.instance.primaryFocus?.unfocus();
        return true;
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              leadingImage: MyImages.backArrow,
              centerTitle: false,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                var cData = context.read<CompanyBloc>();
                cData.add(LoadCompanyListEvent());
                context.read<JobPositionBloc>().add(LoadJobPosListEvent(
                    companyId: cData.companyModel.id.toString()));
                AppRoutes.pop(context);
                print("@@@@@@@ ${cData.companyModel.id.toString()}");
              },
              title: "Search",
            ),
          ),
          body: BlocBuilder<BottomBloc, BottomInitialState>(
              builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: BlocBuilder<CompanyBloc, CompanyState>(
                  builder: (context, state) {
                var data = context.read<CompanyBloc>();
                return Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: IconTextField(
                        controller: search,
                        hint: "Search..",
                        color: MyColors.grey.withOpacity(.40),
                        borderRadius: 25,
                        autofocus: true,
                        prefixIcon: ImageButton(
                          image: MyImages.searchGrey,
                          padding: EdgeInsets.all(14),
                          height: 10,
                          width: 10,
                        ),
                        onChanged: (searchList) {
                          if (Global.userModel?.type == "user") {
                            widget.index == 1
                                ? data.add(JobSearchEvent(search: search.text))
                                : data.add(
                                    CompanySearchEvent(search: search.text));
                          } else {
                            widget.isJobSearch
                                ? data.add(JobSearchEvent(search: search.text))
                                : data.add(
                                    CompanySearchEvent(search: search.text));
                          }

                          // context.read<CompanyBloc>().add(LoadCompanyListEvent());
                        },
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (state is SearchCompanyLoaded) ...[
                              if (state.searchCompanyList.isEmpty ||
                                  search.text.isEmpty)
                                SizedBox(height: 20)
                              else
                                Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                      color: MyColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: MyColors.lightgrey,
                                            blurRadius: 10,
                                            spreadRadius: 4)
                                      ]),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: state.searchCompanyList.length,
                                    itemBuilder: (c, i) {
                                      var companyData =
                                          context.read<CompanyBloc>();
                                      companyData.companyModel =
                                          state.searchCompanyList[i];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.read<JobPositionBloc>().add(
                                                LoadJobPosListEvent(
                                                    companyId: companyData
                                                        .companyModel.id
                                                        .toString()));
                                            context.read<BottomBloc>().add(
                                                SetScreenEvent(true,
                                                    screenName: JobOpeningScreen(
                                                        companyModel: companyData
                                                            .companyModel)));
                                            AppRoutes.push(
                                                context, BottomNavScreen());
                                            // search.clear();
                                          },
                                          child: Text(
                                              "${companyData.companyModel.companyName}"),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return divider();
                                    },
                                  ),
                                ),
                            ],
                            if (state is SearchJobLoaded) ...[
                              if (state.searchJobList.isEmpty ||
                                  search.text.isEmpty)
                                SizedBox(height: 20)
                              else
                                Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                      color: MyColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: MyColors.lightgrey,
                                            blurRadius: 10,
                                            spreadRadius: 4)
                                      ]),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: state.searchJobList.length,
                                    itemBuilder: (c, i) {
                                      var companyData = context
                                          .read<CompanyBloc>()
                                          .companyModel;
                                      var data = state.searchJobList[i];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            print(
                                                "$state clikkkkkkkkkkkkkkkkkkk");
                                            context.read<JobPositionBloc>().add(
                                                LoadJobPosListEvent(
                                                    companyId: data.companyId
                                                        .toString()));
                                            AppRoutes.push(
                                                context,
                                                JobPositionScreen(
                                                    jobPosModel: data,
                                                    companyModel: companyData));
                                            // search.clear();
                                          },
                                          child: Text("${data.designation}"),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return divider();
                                    },
                                  ),
                                ),
                            ],
                            if (state is ErrorState) ...[
                              Center(child: Text(state.error)),
                            ],
                            if (state is CompanyLoading) ...[
                              Center(child: CircularProgressIndicator())
                            ]
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
            );
          })),
    );
  }
}

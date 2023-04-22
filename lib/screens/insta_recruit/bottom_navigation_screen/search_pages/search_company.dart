// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_opening_page.dart';
import 'package:insta_job/utils/app_routes.dart';

import '../../../../bloc/company_bloc/company_bloc.dart';
import '../../../../bloc/company_bloc/company_event.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/my_images.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_button/custom_img_button.dart';
import '../../../../widgets/custom_text_field.dart';

class SearchCompany extends StatefulWidget {
  SearchCompany({Key? key}) : super(key: key);

  @override
  State<SearchCompany> createState() => _SearchCompanyState();
}

class _SearchCompanyState extends State<SearchCompany> {
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            leadingImage: MyImages.backArrow,
            onTap: () {
              context.read<CompanyBloc>().add(LoadCompanyListEvent());
              AppRoutes.pop(context);
            },
            title: "Search Companies",
          ),
        ),
        body: BlocBuilder<BottomBloc, BottomInitialState>(
            builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: BlocBuilder<CompanyBloc, CompanyState>(
                builder: (context, state) {
              return Column(
                children: [
                  IconTextField(
                    controller: search,
                    hint: "Search Companies",
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
                      context.read<CompanyBloc>().add(
                            CompanySearchEvent(search: search.text),
                          );
                      // context.read<CompanyBloc>().add(LoadCompanyListEvent());
                    },
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  if (state is SearchCompanyLoaded) ...[
                    if (state.searchCompanyList.isEmpty || search.text.isEmpty)
                      SizedBox(height: 20)
                    else
                      ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: state.searchCompanyList.length,
                          itemBuilder: (c, i) {
                            var a = state.searchCompanyList[i];
                            return GestureDetector(
                              onTap: () {
                                print("$state clikkkkkkkkkkkkkkkkkkk");
                                context
                                    .read<JobPositionBloc>()
                                    .add(LoadJobPosListEvent());
                                context.read<BottomBloc>().add(SetScreenEvent(
                                    true,
                                    screenName: JobOpeningScreen()));
                                AppRoutes.push(context, BottomNavScreen());
                                // search.clear();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors.lightBlue.withOpacity(.20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${a.companyName}"),
                                      SizedBox(height: 5)
                                      // Divider()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                  ],
                ],
              );
            }),
          );
        }));
  }
}

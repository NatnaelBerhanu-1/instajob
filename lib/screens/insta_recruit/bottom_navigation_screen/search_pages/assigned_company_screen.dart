// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/add_new_company.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_cards/assign_companies_tile.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../bloc/global_cubit/global_cubit.dart';

class AssignCompany extends StatefulWidget {
  const AssignCompany({Key? key}) : super(key: key);

  @override
  State<AssignCompany> createState() => _AssignCompanyState();
}

class _AssignCompanyState extends State<AssignCompany> {
  final TextEditingController search = TextEditingController();

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
                        child: BlocBuilder<CompanyBloc, CompanyState>(
                            builder: (context, state) {
                          return Stack(
                            children: [
                              // Expanded(
                              //   child: ListView.builder(
                              //       itemCount: 2,
                              //       itemBuilder: (context, index) {
                              //         return Container();
                              //       }),
                              // ),
                              CustomTextField(
                                controller: search,
                                hint: "Search Companies",
                                onChanged: (searchList) {
                                  context.read<CompanyBloc>().add(
                                      CompanySearchEvent(search: search.text));
                                },
                              ),
                            ],
                          );
                        }),
                      ),
                      SizedBox(width: 22),
                      Expanded(
                          flex: 0,
                          child: CustomCommonCard(
                            onTap: () {
                              context.read<GlobalCubit>().setSelectedScreen(
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
            Expanded(child: BlocBuilder<CompanyBloc, CompanyState>(
                builder: (context, state) {
              if (state is CompanyLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ErrorState) {
                // showToast(state.error);
                return Center(child: Text(state.error));
              }
              if (state is CompanyLoaded) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.companyList.length,
                    itemBuilder: (c, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 12),
                        child: AssignCompaniesTile(
                          companyModel: state.companyList[i],
                        ),
                      );
                    });
              }
              return Container();
            }))
          ],
        ));
  }
}

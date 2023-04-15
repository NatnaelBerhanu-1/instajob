import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/utils/app_routes.dart';

import '../../../../bloc/company_bloc/company_bloc.dart';
import '../../../../bloc/company_bloc/company_event.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/my_images.dart';
import '../../../../widgets/custom_app_bar.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child:
              BlocBuilder<CompanyBloc, CompanyState>(builder: (context, state) {
            return Column(
              children: [
                CustomTextField(
                  controller: search,
                  hint: "Search Companies",
                  onChanged: (searchList) {
                    context.read<CompanyBloc>().add(
                          CompanySearchEvent(search: search.text),
                        );
                    // context.read<CompanyBloc>().add(LoadCompanyListEvent());
                  },
                  onPressed: () {},
                ),
                if (state is SearchCompanyLoaded) ...[
                  state.searchCompanyList.isEmpty
                      ? SizedBox(height: 50)
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: state.searchCompanyList.length,
                          itemBuilder: (c, i) {
                            var a = state.searchCompanyList[i];
                            return GestureDetector(
                              onTap: () {
                                SizedBox();
                                search.clear();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors.lightBlue,
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
        ));
  }
}

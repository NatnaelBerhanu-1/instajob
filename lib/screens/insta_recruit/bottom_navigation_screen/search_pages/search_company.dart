// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/bloc/location_cubit/location_cubit.dart';
import 'package:insta_job/bloc/location_cubit/location_state.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/model/filter_model.dart';
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
  final bool isAddress;
  final CompanyModel? companyModel;
  const SearchCompany(
      {Key? key,
      this.index,
      this.isJobSearch = false,
      this.companyModel,
      this.isAddress = false})
      : super(key: key);

  @override
  State<SearchCompany> createState() => _SearchCompanyState();
}

class _SearchCompanyState extends State<SearchCompany> {
  final TextEditingController search = TextEditingController();
  final TextEditingController address = TextEditingController();
  // CompanyModel companyData = CompanyModel();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        search.clear();
        FocusManager.instance.primaryFocus?.unfocus();
        var cData = context.read<CompanyBloc>();
        cData.add(LoadCompanyListEvent());
        context.read<JobPositionBloc>().add(
            LoadJobPosListEvent(companyId: widget.companyModel?.id.toString()));
        return true;
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              leadingImage: MyImages.backArrow,
              centerTitle: false,
              onTap: () {
                if (widget.isAddress) {
                  AppRoutes.pop(context);
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();
                  var cData = context.read<CompanyBloc>();
                  cData.add(LoadCompanyListEvent());
                  context.read<JobPositionBloc>().add(LoadJobPosListEvent(
                      companyId: widget.companyModel?.id.toString()));
                  print("@@@@@@@ ${widget.companyModel?.id.toString()}");
                  AppRoutes.pop(context);
                }
              },
              title: "Search",
            ),
          ),
          body: BlocBuilder<BottomBloc, BottomInitialState>(
              builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: widget.isAddress
                  ? BlocBuilder<LocationCubit, LocationInitial>(
                      builder: (context, state) {
                      var locationData = context.read<LocationCubit>();
                      return TypeAheadFormField(
                          getImmediateSuggestions: true,
                          // onSuggestionsBoxToggle: (val) {
                          //   print("@@ ${val}");
                          //   // suggestionVal = val;
                          //   setState(() {});
                          // },
                          validator: (val) =>
                              requiredValidation(val!, "Address"),
                          // suggestionsBoxDecoration: SuggestionsBoxDecoration(),
                          textFieldConfiguration: TextFieldConfiguration(
                              onChanged: (val) {
                                // if (!formKey.currentState!.validate()) {
                                requiredValidation(val, "Address");
                                // }
                              },
                              controller: address,
                              autofocus: true,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Search Address",
                                prefixIcon: Icon(Icons.location_on_outlined,
                                    size: 25, color: MyColors.blue),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: MyColors.lightGrey, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: MyColors.lightGrey, width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: MyColors.lightGrey, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: MyColors.lightGrey, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: MyColors.lightGrey, width: 1),
                                ),
                              )),
                          hideOnLoading: true,
                          suggestionsCallback: (pattern) async {
                            return await locationData.getLocation(address.text);
                          },
                          // autoFlipDirection: true,
                          itemBuilder: (c, location) {
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              title: Text("${location.description}"),
                            );
                          },
                          onSuggestionSelected: (pattern) async {
                            print("SELECTED");
                            address.text = pattern.description.toString();
                            await locationData.getPlaceById(pattern.placeId);
                            locationData.getAddress(pattern.description);
                            // locationData.address =
                            //     pattern.description.toString();
                            // setState(() {});
                            Navigator.of(context).pop();
                          });
                    })
                  : BlocBuilder<JobPositionBloc, JobPosState>(
                      bloc: context.read<JobPositionBloc>(),
                      builder: (context, jobState) {
                        return BlocBuilder<CompanyBloc, CompanyState>(
                            bloc: context.read<CompanyBloc>(),
                            builder: (context, companyState) {
                              var data = context.read<CompanyBloc>();
                              var jobData = context.read<JobPositionBloc>();
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
                                              ? jobData.add(JobSearchEvent(
                                                  filterModel: FilterModel(
                                                      searchJobs: search.text)))
                                              : data.add(CompanySearchEvent(
                                                  search: search.text));
                                        } else {
                                          widget.isJobSearch
                                              ? jobData.add(JobSearchEvent(
                                                  filterModel: FilterModel(
                                                      searchJobs: search.text)))
                                              : data.add(CompanySearchEvent(
                                                  search: search.text));
                                        }
                                        // context.read<CompanyBloc>().add(LoadCompanyListEvent());
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          if (companyState
                                              is SearchCompanyLoaded) ...[
                                            // if (companyState.companyList.isEmpty ||
                                            //     search.text.isEmpty)
                                            //   SizedBox(height: 20)
                                            // else
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 8, bottom: 8),
                                              decoration: BoxDecoration(
                                                  color: MyColors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:
                                                            MyColors.lightgrey,
                                                        blurRadius: 10,
                                                        spreadRadius: 4)
                                                  ]),
                                              child: ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount: companyState
                                                    .searchCompanyList.length,
                                                itemBuilder: (c, i) {
                                                  var companyData = context
                                                      .read<CompanyBloc>();
                                                  companyData.companyModel =
                                                      companyState
                                                          .searchCompanyList[i];
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 10),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                JobPositionBloc>()
                                                            .add(LoadJobPosListEvent(
                                                                companyId: companyData
                                                                    .companyModel
                                                                    .id
                                                                    .toString()));
                                                        context
                                                            .read<BottomBloc>()
                                                            .add(SetScreenEvent(
                                                                true,
                                                                screenName: JobOpeningScreen(
                                                                    companyModel:
                                                                        companyData
                                                                            .companyModel)));
                                                        AppRoutes.push(context,
                                                            BottomNavScreen());
                                                        // search.clear();
                                                      },
                                                      child: Text(
                                                          "${companyData.companyModel.companyName}"),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return divider();
                                                },
                                              ),
                                            ),
                                          ],
                                          if (jobState is JobSearchLoaded) ...[
                                            if (jobState
                                                    .searchJobPosList.isEmpty ||
                                                search.text.isEmpty)
                                              SizedBox(height: 20)
                                            else
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 8, bottom: 8),
                                                decoration: BoxDecoration(
                                                    color: MyColors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: MyColors
                                                              .lightgrey,
                                                          blurRadius: 10,
                                                          spreadRadius: 4)
                                                    ]),
                                                child: ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount: jobState
                                                      .searchJobPosList.length,
                                                  itemBuilder: (c, i) {
                                                    var companyData = context
                                                        .read<CompanyBloc>()
                                                        .companyModel;
                                                    var data = jobState
                                                        .searchJobPosList[i];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0,
                                                          horizontal: 10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          print(
                                                              "$companyState clikkkkkkkkkkkkkkkkkkk");
                                                          context
                                                              .read<
                                                                  JobPositionBloc>()
                                                              .add(LoadJobPosListEvent(
                                                                  companyId: data
                                                                      .companyId
                                                                      .toString()));
                                                          AppRoutes.push(
                                                              context,
                                                              JobPositionScreen(
                                                                  jobPosModel:
                                                                      data,
                                                                  companyModel:
                                                                      companyData));
                                                          // search.clear();
                                                        },
                                                        child: Text(
                                                            "${data.designation}"),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return divider();
                                                  },
                                                ),
                                              ),
                                          ],
                                          if (companyState is ErrorState) ...[
                                            Center(
                                                child:
                                                    Text(companyState.error)),
                                          ],
                                          // if (jobState is JobErrorState) ...[
                                          //   Center(child: Text(jobState.error)),
                                          // ],
                                          if (companyState
                                              is CompanyLoading) ...[
                                            Center(
                                                child:
                                                    CircularProgressIndicator())
                                          ]
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      }),
            );
          })),
    );
  }
}

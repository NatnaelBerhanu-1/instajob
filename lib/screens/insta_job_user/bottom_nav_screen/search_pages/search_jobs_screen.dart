// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/filter_tiles/custom_filter_tile.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/map_tile.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../utils/my_colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_button/custom_img_button.dart';
import '../../../../widgets/custom_cards/assign_companies_tile.dart';
import '../../../../widgets/custom_cards/insta_job_user_cards/search_job_tile.dart';
import '../../../../widgets/custom_chip.dart';
import '../../../insta_recruit/bottom_navigation_screen/search_pages/search_company.dart';
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
  void initState() {
    context.read<JobPositionBloc>().add(LoadJobPosListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var selectedFilterIndex = context.watch<GlobalCubit>().fIndex;
    var selectedSearchIndex = context.watch<GlobalCubit>().sIndex;
    return Scaffold(
        backgroundColor: MyColors.white,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: selectedFilterIndex == 1 || selectedFilterIndex == 2
              ? SafeArea(
                  child: Row(
                  children: [
                    Expanded(
                      flex: 0,
                      child: GestureDetector(
                        onTap: () {
                          context.read<GlobalCubit>().changeFilterIndex(0);
                        },
                        child: Image.asset(
                          MyImages.backArrow,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CustomTextField(
                        hint: "Search",
                        suffixIcon: ImageButton(
                            image: MyImages.searchBlue,
                            height: 20,
                            width: 20,
                            padding: EdgeInsets.all(10)),
                        borderRadius: 30,
                      ),
                    )),
                  ],
                ))
              : PreferredSize(
                  preferredSize: Size(double.infinity, kToolbarHeight),
                  child: CustomAppBar(
                    title: selectedSearchIndex == 1
                        ? "Search Jobs"
                        : "Search Companies",
                    centerTitle: false,
                    leadingImage: "",
                    leadingWidth: 5,
                    onTap: () {},
                    actions: ImageButton(
                      image: MyImages.searchBlue,
                      padding: EdgeInsets.only(left: 10, right: 20),
                      onTap: () {
                        AppRoutes.push(
                            context, SearchCompany(index: selectedSearchIndex));
                      },
                    ),
                  )),
        ),
        body: Container(
          color: MyColors.white,
          child:
              BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: selectedFilterIndex == 1 || selectedFilterIndex == 2
                      ? EdgeInsets.only(left: 10.0, top: 10)
                      : EdgeInsets.only(left: 10.0),
                  child: Row(
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
                                                  .read<GlobalCubit>()
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
                ),
                SizedBox(height: 20),
                if (selectedFilterIndex == 0) ...[
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: CustomSearchChip(
                                onTap: () {
                                  context.read<GlobalCubit>().changeIndex(1);
                                  context
                                      .read<JobPositionBloc>()
                                      .add(LoadJobPosListEvent());
                                },
                                image: MyImages.suitcase,
                                index: 1,
                                selectedIndex: selectedSearchIndex,
                                title: "Search Jobs",
                              )),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CustomSearchChip(
                                onTap: () {
                                  context.read<GlobalCubit>().changeIndex(2);
                                  context
                                      .read<CompanyBloc>()
                                      .add(LoadCompanyListEvent());
                                },
                                index: 2,
                                selectedIndex: selectedSearchIndex,
                                title: "Search Companies",
                              )),
                            ],
                          ),
                          SizedBox(height: 20),
                          Expanded(
                              child: selectedSearchIndex == 1
                                  ? BlocBuilder<JobPositionBloc, JobPosState>(
                                      builder: (context, state) {
                                      if (state is JobPosLoaded) {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.jobPosList.length,
                                            itemBuilder: (c, i) {
                                              var data = state.jobPosList[i];
                                              return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 7,
                                                      horizontal: 5),
                                                  child: SearchJobTile(
                                                      jobPosModel: data));
                                            });
                                      }
                                      if (state is JobPosLoading) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (state is JobErrorState) {
                                        return Center(child: Text(state.error));
                                      }
                                      return SizedBox();
                                    })
                                  : BlocBuilder<CompanyBloc, CompanyState>(
                                      builder: (context, state) {
                                      if (state is CompanyLoaded) {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.companyList.length,
                                            itemBuilder: (c, i) {
                                              var data = state.companyList[i];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7,
                                                        horizontal: 5),
                                                child: AssignCompaniesTile(
                                                    companyModel: data
                                                    // leadingImage:
                                                    //     MyImages.businessAndTrade,
                                                    // title: "Ford",
                                                    ),
                                              );
                                            });
                                      }
                                      if (state is CompanyLoading) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (state is ErrorState) {
                                        return Center(child: Text(state.error));
                                      }
                                      return SizedBox();
                                    })),
                        ],
                      ),
                    ),
                  )
                ] else if (selectedFilterIndex == 1 ||
                    selectedFilterIndex == 2) ...[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BlocBuilder<GlobalCubit, InitialState>(
                            builder: (context, state) {
                          var value = context.read<GlobalCubit>();
                          return Slider(
                            value: value.range,
                            onChanged: (val) {
                              value.rangeVal(val);
                            },
                            max: 100,
                            min: 10,
                          );
                        }),
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.74,
                              color: MyColors.grey,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(0.0, 22.90), zoom: 14),
                                zoomControlsEnabled: true,
                                zoomGesturesEnabled: true,
                                scrollGesturesEnabled: true,
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.27),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: SizedBox(
                                height: 220,
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
        ));
  }
}

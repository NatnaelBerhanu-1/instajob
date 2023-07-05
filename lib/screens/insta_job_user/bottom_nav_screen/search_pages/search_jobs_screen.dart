// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/bloc/location_cubit/location_cubit.dart';
import 'package:insta_job/bloc/location_cubit/location_state.dart';
import 'package:insta_job/screens/insta_job_user/bottom_nav_screen/search_pages/custom_search_page.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/filter_tiles/custom_filter_tile.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/map_tile.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../utils/my_colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_button/custom_img_button.dart';
import '../../../insta_recruit/bottom_navigation_screen/search_pages/search_company.dart';
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

  // Set<Marker> setOfMarker = {};
  // CameraPosition? cameraPosition;
  // getCurrent() {
  //   var locationData = context.read<JobPositionBloc>();
  //
  //   print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
  //   setState(() {
  //     for (int i = 0; i < locationData.jobDistanceList.length; i++) {
  //       print("|||||||||||||| FOR LOOP |||||||||||||||");
  //       var jobData = locationData.jobDistanceList[i];
  //       final marker = Marker(
  //           markerId: MarkerId(jobData.id.toString()),
  //           position: LatLng(
  //             double.parse(jobData.cLat.toString()),
  //             double.parse(jobData.cLog.toString()),
  //           ),
  //           infoWindow: InfoWindow(title: jobData.designation));
  //       setOfMarker.add(marker);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var jobDistanceIndex = context.watch<GlobalCubit>().fIndex;
    var selectedSearchIndex = context.read<GlobalCubit>().sIndex;
    return Scaffold(
        backgroundColor: MyColors.white,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: jobDistanceIndex == 1 || jobDistanceIndex == 2
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
            var value = context.read<GlobalCubit>();
            return Column(
              children: [
                Padding(
                  padding: jobDistanceIndex == 1 || jobDistanceIndex == 2
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
                                  3,
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
                                              if (index == 0) {
                                                context
                                                    .read<JobPositionBloc>()
                                                    .add(LoadJobPosListEvent());
                                              }
                                            },
                                            selectedIndex: jobDistanceIndex,
                                            index: index,
                                            title: [
                                              "${context.read<LocationCubit>().placeMarks.first.name}",
                                              "Job Distance Locator",
                                              "${context.read<GlobalCubit>().range.toStringAsFixed(0)} Miles Away"
                                            ][index],
                                          ),
                                        ),
                                      )),
                            )),
                      ),
                      SizedBox(width: 7),
                      Expanded(
                          flex: 0,
                          child: selectedSearchIndex == 2
                              ? SizedBox(width: 5)
                              : GestureDetector(
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
                jobDistanceIndex == 1 || jobDistanceIndex == 2
                    ? Slider(
                        value: value.range,
                        onChanged: (val) {
                          value.rangeVal(val);
                          context.read<LocationCubit>().onMapCreated(context);
                          // setState(() {});
                        },
                        onChangeEnd: (val) {
                          print("END $val");
                          context
                              .read<JobPositionBloc>()
                              .add(JobDistanceLocatorEvent(
                                miles: val.toStringAsFixed(0),
                                designation: "",
                              ));
                          context.read<LocationCubit>().onMapCreated(context);
                          // setState(() {});
                        },
                        max: 100,
                        min: 0,
                      )
                    : SizedBox(),
                jobDistanceIndex == 1 || jobDistanceIndex == 2
                    ? SizedBox(height: 0)
                    : SizedBox(height: 25),
                if (jobDistanceIndex == 0) ...[
                  CompanyJobChip(selectedSearchIndex: selectedSearchIndex)
                ] else if (jobDistanceIndex == 1 || jobDistanceIndex == 2) ...[
                  BlocBuilder<LocationCubit, LocationInitial>(
                      builder: (context, state) {
                    var locationData = context.read<LocationCubit>();
                    return Expanded(
                        child: ListView(
                      children: [
                        BlocBuilder<JobPositionBloc, JobPosState>(
                            builder: (context, jobState) {
                          var jobData = context.read<JobPositionBloc>();
                          print("STATE: $jobState");
                          return Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.74,
                                color: MyColors.grey,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(locationData.latitude,
                                          locationData.longitude),
                                      zoom: 8),
                                  zoomControlsEnabled: true,
                                  padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.32),
                                  markers: locationData.setOfMarker,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    locationData.onMapCreated(context);
                                    // setState(() {});
                                    /* locationData.googleMapController =
                                        controller;
                                    controller.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: LatLng(
                                                    locationData.latitude,
                                                    locationData.longitude),
                                                zoom: 12)));
                                    if (jobState is JobDistanceLoaded) {
                                      print(
                                          "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                                      for (int i = 0;
                                          i < jobState.jobList.length;
                                          i++) {
                                        print("@@@@@@@@@@@@@@@@@@@@@");
                                        var jobData = jobState.jobList[i];
                                        var marker = Marker(
                                          markerId:
                                              MarkerId(jobData.id.toString()),
                                          position: LatLng(
                                            double.parse(
                                                jobData.cLat.toString()),
                                            double.parse(
                                                jobData.cLog.toString()),
                                          ),
                                        );
                                        setOfMarker.add(marker);
                                      }
                                    }
                                    setState(() {});*/
                                  },
                                ),
                              ),
                              // if (jobState is JobDistanceLoaded) ...[
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
                                        itemCount:
                                            jobData.jobDistanceList.length,
                                        itemBuilder: (c, i) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                // AppRoutes.push(
                                                //     context,
                                                //     JobPositionScreen(
                                                //       jobPosModel: jobData
                                                //           .jobDistanceList[i],
                                                //     ));
                                              },
                                              child: MapTile(
                                                jobDistanceModel:
                                                    jobData.jobDistanceList[i],
                                              ),
                                            ),
                                          );
                                        })),
                              ),
                              // ],

                              if (jobState is JobPosLoading) ...[
                                Center(child: CircularProgressIndicator())
                              ]
                            ],
                          );
                        }),
                      ],
                    ));
                  }),
                ] else
                  ...[],
              ],
            );
          }),
        ));
  }
}

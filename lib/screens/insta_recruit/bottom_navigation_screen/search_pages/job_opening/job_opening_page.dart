// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/assigned_company_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/add_job_position_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/search_company.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_cards/job_opening_tile.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../../bloc/bottom_bloc/bottom_bloc.dart';

class JobOpeningScreen extends StatefulWidget {
  final CompanyModel? companyModel;

  const JobOpeningScreen({Key? key, this.companyModel}) : super(key: key);

  @override
  State<JobOpeningScreen> createState() => _JobOpeningScreenState();
}

class _JobOpeningScreenState extends State<JobOpeningScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        print('============ $val');
        context.read<CompanyBloc>().add(LoadCompanyListEvent());
        context.read<BottomBloc>().add(SetScreenEvent(false, screenName: AssignCompany()));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 90),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6).copyWith(top: 28),
                child: Row(
                  // elevation: 0,
                  // leadingWidth: 50,
                  // backgroundColor: MyColors.white,
                  // toolbarHeight: 70,
                  // title:
                  children: [
                    ImageButton(
                      image: MyImages.backArrowBorder,
                      color: MyColors.blue,
                      height: 28,
                      width: 28,
                      padding: EdgeInsets.all(9.0),
                      onTap: () {
                        context.read<CompanyBloc>().add(LoadCompanyListEvent());
                        context.read<BottomBloc>().add(SetScreenEvent(false, screenName: AssignCompany()));
                        // context.read<BottomCubit>().setSelectedScreen(false,
                        //     screenName: JobOpeningScreen());
                        // Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 5),
                    Global.userModel?.type == "user"
                        ? Expanded(
                            child: CommonText(
                              text: " ${widget.companyModel?.companyName}",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          )
                        : Expanded(
                            child: IconTextField(
                              prefixIcon: ImageButton(
                                image: MyImages.searchGrey,
                                padding: EdgeInsets.all(14),
                                height: 10,
                                width: 10,
                              ),
                              readOnly: true,
                              borderRadius: 25,
                              hint: "search",
                              onPressed: () {
                                AppRoutes.push(
                                    context,
                                    SearchCompany(
                                      isJobSearch: true,
                                      companyModel: widget.companyModel,
                                    ));
                              },
                            ),
                          ),
                    SizedBox(width: 5),
                    Global.userModel?.type == "user"
                        ? ImageButton(
                            image: MyImages.searchBlue,
                            padding: EdgeInsets.only(left: 10, right: 20),
                            onTap: () {
                              AppRoutes.push(context, SearchCompany(index: 2, companyModel: widget.companyModel));
                            },
                          )
                        : GestureDetector(
                            onTap: () {
                              context.read<BottomBloc>().add(SetScreenEvent(true,
                                  screenName: AddJobPositionScreen(
                                    companyModel: widget.companyModel,
                                  )));
                              // AppRoutes.push(context, EditListing());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0, left: 10),
                              child: Container(
                                decoration: BoxDecoration(color: MyColors.blue, shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Icon(
                                    Icons.add,
                                    color: MyColors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            )),
        body: Column(
          children: [
            SizedBox(height: 12),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
              child: Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image:
                            CachedNetworkImageProvider("${EndPoint.imageBaseUrl}${widget.companyModel?.uploadPhoto}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    width: double.maxFinite,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black54, Colors.black12],
                      ),
                    )),
                  ),
                  // Text content
                  Positioned(
                    bottom: 18,
                    left: 12,
                    right: 24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company name
                        CommonText(
                          text: "${widget.companyModel?.companyName}",
                          fontColor: MyColors.white,
                          fontSize: 20,
                        ),
                        SizedBox(height: 8),
                        // Description text
                        CommonText(
                          text:
                              "It's a long established fact that reader will directly by the readable content of page when looking at it's layout",
                          fontColor: MyColors.white,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<JobPositionBloc, JobPosState>(builder: (context, state) {
                if (state is JobPosLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is JobErrorState) {
                  return Center(child: Text(state.error));
                }
                if (state is JobPosLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                    child: ListView.builder(
                        itemCount: state.jobPosList.length,
                        itemBuilder: (c, i) {
                          var data = state.jobPosList[i];
                          return JobOpeningTile(jobPosModel: data, companyModel: widget.companyModel);
                        }),
                  );
                }
                return SizedBox();
              }),
            )
          ],
        ),
      ),
    );
  }
}

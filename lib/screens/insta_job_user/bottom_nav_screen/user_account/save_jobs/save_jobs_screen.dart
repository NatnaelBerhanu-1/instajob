// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/search_pages/job_opening/job_position_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/cluster_widget/custom_career_tile.dart';

import '../../../../../widgets/custom_app_bar.dart';

class SaveJobsScreen extends StatefulWidget {
  const SaveJobsScreen({Key? key}) : super(key: key);

  @override
  State<SaveJobsScreen> createState() => _SaveJobsScreenState();
}

class _SaveJobsScreenState extends State<SaveJobsScreen>
    with SingleTickerProviderStateMixin {
  // TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    // tabController = TabController(length: 2, vsync: this);
    // tabController?.addListener(() {
    //   if (tabController?.index == 0) {
    //     context.read<JobPositionBloc>().add(SavedJobPositionListEvent());
    //   } else {
    //     context.read<JobPositionBloc>().add(AppliedJobListEvent());
    //   }
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<JobPositionBloc>().add(SavedJobPositionListEvent());
        context.read<JobPositionBloc>().add(AppliedJobListEvent());
        return true;
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, kToolbarHeight),
              child: CustomAppBar(
                title: "Saved Jobs",
              )),
          body: Column(
            children: [
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: TabBar(
                              // controller: tabController,
                              unselectedLabelColor: MyColors.tabClr,
                              labelColor: MyColors.blue,
                              indicatorColor: MyColors.blue,
                              onTap: (val) {
                                if (val == 0) {
                                  context
                                      .read<JobPositionBloc>()
                                      .add(SavedJobPositionListEvent());
                                } else {
                                  context
                                      .read<JobPositionBloc>()
                                      .add(
                                      AppliedJobListEvent(status: "applied"));
                                }
                              },
                              tabs: [
                                Tab(text: "Saved"),
                                Tab(text: "Applied"),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<JobPositionBloc, JobPosState>(
                            // buildWhen: (p,c)=>c is SaveJobPosLoaded   ,
                            builder: (context, state) {
                          print('QQQQQQQQQQ $state');
                          return TabBarView(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: state is SaveJobPosLoaded
                                  ? GridView.builder(
                                      itemCount: state.jobPosList.length,
                                      itemBuilder: (c, i) {
                                        return GestureDetector(
                                          onTap: () {
                                            AppRoutes.push(
                                                context,
                                                JobPositionScreen(
                                                  jobPosModel:
                                                      state.jobPosList[i],
                                                  // companyModel: context
                                                  //     .read<CompanyBloc>()
                                                  //     .companyModel,
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 8),
                                            child: AppliedTile(
                                                isFav: true,
                                                jobPosModel:
                                                    state.jobPosList[i]),
                                          ),
                                        );
                                      },
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 0,
                                              mainAxisSpacing: 0,
                                              childAspectRatio: 5.1 / 4.5),
                                    )
                                  : state is JobErrorState
                                      ? Center(child: Text(state.error))
                                      : state is JobPosLoading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : SizedBox.shrink(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: state is AppliedJobLoaded
                                  ? GridView.builder(
                                      itemCount: state.appliedJobList.length,
                                      itemBuilder: (c, i) {
                                        return GestureDetector(
                                          onTap: () {
                                            AppRoutes.push(
                                                context,
                                                JobPositionScreen(
                                                  jobPosModel:
                                                      state.appliedJobList[i],
                                                  // companyModel: context
                                                  //     .read<CompanyBloc>()
                                                  //     .companyModel,
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 8),
                                            child: AppliedTile(
                                                isFav: true,
                                                jobPosModel:
                                                    state.appliedJobList[i]),
                                          ),
                                        );
                                      },
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 0,
                                              mainAxisSpacing: 0,
                                              childAspectRatio: 5.1 / 4.5),
                                    )
                                  : (state is ApplyErrorState ||
                                          state is JobErrorState)
                                      ? Center(
                                          child: Text(
                                              "${state is ApplyErrorState ? state.error : ""}${state is JobErrorState ? state.error : ""}"))
                                      : state is ApplyLoading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : SizedBox.shrink(),
                            ),
                          ]);
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

/**/

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/custom_career_tile.dart';

import '../../../../../widgets/custom_app_bar.dart';

class SaveJobsScreen extends StatefulWidget {
  const SaveJobsScreen({Key? key}) : super(key: key);

  @override
  State<SaveJobsScreen> createState() => _SaveJobsScreenState();
}

class _SaveJobsScreenState extends State<SaveJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            unselectedLabelColor: MyColors.tabClr,
                            labelColor: MyColors.blue,
                            tabs: [
                              Tab(text: "Saved"),
                              Tab(text: "Applied"),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<JobPositionBloc, JobPosState>(
                          builder: (context, state) {
                        return TabBarView(children: [
                          if (state is JobPosLoaded) ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                itemCount: state.jobPosList.length,
                                itemBuilder: (c, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 8),
                                    child: AppliedTile(
                                        isFav: true,
                                        jobPosModel: state.jobPosList[i]),
                                  );
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0,
                                        childAspectRatio: 5.5 / 5),
                              ),
                            )
                          ],
                          if (state is JobPosLoading) ...[
                            Center(child: CircularProgressIndicator()),
                          ],
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              itemCount: 10,
                              itemBuilder: (c, i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 8),
                                  child: AppliedTile(),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0),
                            ),
                          ),
                        ]);
                      }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

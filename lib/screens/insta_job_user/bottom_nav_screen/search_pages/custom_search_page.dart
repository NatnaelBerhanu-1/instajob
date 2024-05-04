// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/company_bloc/company_state.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_chip.dart';

import '../../../../widgets/custom_cards/assign_companies_tile.dart';
import '../../../../widgets/custom_cards/insta_job_user_cards/search_job_tile.dart';

class CompanyJobChip extends StatelessWidget {
  const CompanyJobChip({
    super.key,
    required this.selectedSearchIndex,
  });

  final int selectedSearchIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: CustomSearchChip(
                  onTap: () {
                    context.read<GlobalCubit>().changeIndex(1);
                    context.read<JobPositionBloc>().add(LoadJobPosListEvent());
                  },
                  image: MyImages.suitcase,
                  index: 1,
                  selectedIndex: selectedSearchIndex,
                  title: "Search Jobs",
                )),
                SizedBox(width: 7),
                Expanded(
                    child: CustomSearchChip(
                  onTap: () {
                    context.read<GlobalCubit>().changeIndex(2);
                    context.read<CompanyBloc>().add(LoadCompanyListEvent());
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
                    ? BlocConsumer<JobPositionBloc, JobPosState>(
                        listener: (context, state) {
                        if (state is SaveJobPosLoaded) {
                          if (Global.userModel?.type == "user") {
                            context
                                .read<JobPositionBloc>()
                                .add(LoadJobPosListEvent());
                          }
                        }
                      },
                        // buildWhen: (previous,current)=> current is JobPosLoaded,
                        builder: (context, state) {
                        if (state is JobPosLoaded) {
                          print('&&&&&&&&&&&&&&&&&&&&&&& ${state.jobPosList.length}');
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.jobPosList.length,
                              itemBuilder: (c, i) {
                                var data = state.jobPosList[i];
                                context.read<JobPositionBloc>().jobModel = data;
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 5),
                                    child: SearchJobTile(
                                        companyModel: context
                                            .read<CompanyBloc>()
                                            .companyModel,
                                        jobPosModel: data));
                              });
                        }
                        if (state is JobSearchLoaded) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.searchJobPosList.length,
                              itemBuilder: (c, i) {
                                var data = state.searchJobPosList[i];
                                context.read<JobPositionBloc>().jobModel = data;
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 5),
                                    child: SearchJobTile(
                                        companyModel: context
                                            .read<CompanyBloc>()
                                            .companyModel,
                                        jobPosModel: data));
                              });
                        }
                        if (state is JobPosLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is JobErrorState) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(state.error),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  title: 'Try again',
                                  width: 100,
                                  height: 40,
                                  onTap: () {
                                    context.read<JobPositionBloc>().add(LoadJobPosListEvent());
                                  },
                                )
                              ],
                            ),
                          );
                        }
                        return SizedBox();
                      })
                    : BlocBuilder<CompanyBloc, CompanyState>(
                        builder: (context, state) {
                        if (state is CompanyLoaded) {
                          var companyData = context.read<CompanyBloc>();
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.companyList.length,
                              itemBuilder: (c, i) {
                                companyData.companyModel = state.companyList[i];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 5),
                                  child: AssignCompaniesTile(
                                      companyModel: companyData.companyModel
                                      // leadingImage:
                                      //     MyImages.businessAndTrade,
                                      // title: "Ford",
                                      ),
                                );
                              });
                        }
                        if (state is CompanyLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is ErrorState) {
                          return Center(child: Text(state.error));
                        }
                        return SizedBox();
                      })),
          ],
        ),
      ),
    );
  }
}

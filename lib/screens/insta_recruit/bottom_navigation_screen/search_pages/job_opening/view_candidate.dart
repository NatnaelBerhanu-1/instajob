// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_state.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/screens/insta_recruit/new_email_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/candidate_tile.dart';
import 'package:pinput/pinput.dart';

import '../../../../../utils/app_routes.dart';
import '../../../../../utils/my_images.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button/custom_img_button.dart';
import '../search_trash_screen.dart';

class ViewCandidates extends StatefulWidget {
  final JobPosModel? jobPosModel;
  final CompanyModel? companyModel;

  const ViewCandidates({
    Key? key,
    this.jobPosModel,
    this.companyModel,
  }) : super(key: key);

  @override
  State<ViewCandidates> createState() => _ViewCandidatesState();
}

class _ViewCandidatesState extends State<ViewCandidates> {
  int selectedTab = 0;
  bool isCheck = false;
  late Set<int> selectedCandidatesIndices;
  @override
  void initState() {
    super.initState();
    selectedCandidatesIndices = <int>{};
    context.read<JobPositionBloc>().add(AppliedJobListEvent(
          jobId: widget.jobPosModel?.id.toString(),
        ));
    ;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            leadingImage: MyImages.backArrow,
            onTap: () {
              // AppRoutes.pushAndRemoveUntil(
              //     context,
              //     JobPositionScreen(
              //         companyModel: widget.companyModel,
              //         jobPosModel: widget.jobPosModel));
              // context.read<BottomBloc>().add(SetScreenEvent(true,
              //     screenName: JobPositionScreen(
              //         companyModel: companyModel, jobPosModel: jobPosModel)));
              // AppRoutes.pop(context);
              Navigator.of(context).pop();
            },
            centerTitle: false,
            title: "Candidates",
            actions: Row(
              children: [
                if (selectedCandidatesIndices.isNotEmpty)
                  BlocBuilder<JobPositionBloc, JobPosState>(
                      builder: (context, appliedState) {
                    return ImageButton(
                      image: MyImages.logout,
                      color: MyColors.blue,
                      onTap: () {
                        List<String> resumesPath = [];
                        if (appliedState is AppliedJobLoaded) {
                          for (var currSelectedIdx
                              in selectedCandidatesIndices) {
                            String? currResumeUrl = appliedState
                                .appliedOnly[currSelectedIdx].uploadResume;
                            if (currResumeUrl != null) {
                              resumesPath.add(currResumeUrl);
                            }
                          }
                        }
                        AppRoutes.push(
                            context, NewEmailScreen(resumesPath: resumesPath));
                      },
                    );
                  }),
                // ImageButton(
                //   image: MyImages.searchBlue,
                // ),
                BlocBuilder<GlobalCubit, InitialState>(
                    builder: (context, state) {
                  var tab = context.read<GlobalCubit>();
                  return ImageButton(
                    onTap: () {
                      tab.changeTabValue(4);
                      AppRoutes.push(context,
                          SearchTrash(jobPosModel: widget.jobPosModel));
                      context.read<JobPositionBloc>().add(AppliedJobListEvent(
                          jobId: widget.jobPosModel!.id.toString(),
                          status: "denied"));
                    },
                    image: MyImages.delete,
                    height: 19,
                    width: 19,
                  );
                }),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      BlocBuilder<GlobalCubit, InitialState>(
                          builder: (context, state) {
                        var tab = context.read<GlobalCubit>();
                        return TabBar(
                          labelColor: MyColors.blue,
                          indicatorColor: MyColors.blue,
                          unselectedLabelColor: MyColors.tabClr,
                          onTap: (val) {
                            tab.changeTabValue(val);
                            print("!!!!!!!!!!!!!!! $val");
                            if (val == 0) {
                              context
                                  .read<JobPositionBloc>()
                                  .add(AppliedJobListEvent(
                                    jobId: widget.jobPosModel!.id.toString(),
                                  ));
                            }
                            if (val == 1) {
                              context
                                  .read<JobPositionBloc>()
                                  .add(AppliedJobListEvent(
                                    jobId: widget.jobPosModel!.id.toString(),
                                  ));
                            }
                            if (val == 3) {
                              // context.read<JobPositionBloc>().add(
                              //     AppliedJobListEvent(
                              //         jobId: widget.jobPosModel!.id.toString(),
                              //         status: "denied"));
                            }
                            selectedCandidatesIndices.clear();
                            setState(() {});
                          },
                          tabs: [
                            Tab(text: "Applied"),
                            Tab(text: "Shortlisted"),
                            Tab(text: "Messages"),
                          ],
                        );
                      }),
                      Expanded(child: BlocBuilder<JobPositionBloc, JobPosState>(
                          builder: (context, appliedState) {
                        return TabBarView(children: [
                          if (appliedState is AppliedJobLoaded) ...[
                            ListView.builder(
                                itemCount: appliedState.appliedOnly.length,
                                itemBuilder: (c, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10),
                                    child:
                                        BlocBuilder<GlobalCubit, InitialState>(
                                            builder: (context, state) {
                                      return CandidateTile(
                                        onchange: (val) {
                                          context
                                              .read<GlobalCubit>()
                                              .onSelected(val, i,
                                                  email: appliedState
                                                      .appliedOnly[i]
                                                      .userEmail);
                                          if (val == true) {
                                            selectedCandidatesIndices.add(i);
                                          } else if (val == false &&
                                              selectedCandidatesIndices
                                                  .contains(i)) {
                                            selectedCandidatesIndices.remove(i);
                                          }
                                          setState(() {});
                                        },
                                        value: selectedCandidatesIndices
                                            .contains(i),
                                        appliedJobModel:
                                            appliedState.appliedOnly[i],
                                        selectedIndex: i,
                                        fullFilteredApplicantsList:
                                            appliedState.appliedOnly,
                                      );
                                    }),
                                  );
                                }),
                          ],
                          if (appliedState is ApplyLoading) ...[
                            Center(child: CircularProgressIndicator())
                          ],
                          if (appliedState is AppliedJobLoaded) ...[
                            ListView.builder(
                                itemCount: appliedState.shortlisted.length,
                                itemBuilder: (c, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10),
                                    child:
                                        BlocBuilder<GlobalCubit, InitialState>(
                                            builder: (context, state) {
                                      return CandidateTile(
                                        onchange: (val) {
                                          context
                                              .read<GlobalCubit>()
                                              .onSelected(val, i);
                                          setState(() {});
                                        },
                                        value: selectedCandidatesIndices
                                            .contains(i),
                                        appliedJobModel:
                                            appliedState.shortlisted[i],
                                        selectedIndex: i,
                                        fullFilteredApplicantsList:
                                            appliedState.shortlisted,
                                      );
                                    }),
                                  );
                                }),
                          ],
                          if (appliedState is ApplyLoading) ...[
                            Center(child: CircularProgressIndicator())
                          ],
                          SizedBox()
                          /* BlocBuilder<JobPositionBloc, JobPosState>(
                              builder: (context, state) {
                            if (state is AppliedJobLoaded) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.appliedJobList.length,
                                  itemBuilder: (c, i) {
                                    var data = state.appliedJobList[i];
                                    return MessageTile(
                                      jobPosModel: data,
                                    );
                                  });
                            }
                            if (state is ApplyLoading) {
                              Center(child: CircularProgressIndicator());
                            }
                            if (state is ApplyErrorState) {
                              Center(child: Text(state.error));
                            }
                            return SizedBox();
                          }),*/
                        ]);
                      }))
                    ],
                  )),
            )
            // ImageButton(image: ,)
          ],
        ));
  }
}

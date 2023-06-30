// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/bloc/job_position/job_pos_state.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/widgets/candidate_tile.dart';

import '../../../../utils/my_colors.dart';
import '../../../../utils/my_images.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_cards/notifications_tile/message_tile.dart';

class SearchTrash extends StatefulWidget {
  final JobPosModel? jobPosModel;
  const SearchTrash({Key? key, this.jobPosModel}) : super(key: key);

  @override
  State<SearchTrash> createState() => _SearchTrashState();
}

class _SearchTrashState extends State<SearchTrash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            leadingImage: MyImages.backArrow,
            centerTitle: false,
            title: "Trash",
            onTap: () {
              context.read<JobPositionBloc>().add(AppliedJobListEvent(
                  jobId: widget.jobPosModel!.id.toString()));
              Navigator.of(context).pop();
            },
            // actions: ImageButton(
            //   image: MyImages.searchBlue,
            // ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<JobPositionBloc, JobPosState>(
                  builder: (context, appliedState) {
                return DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: MyColors.blue,
                          indicatorColor: MyColors.blue,
                          onTap: (val) {
                            if (val == 0) {
                              context.read<JobPositionBloc>().add(
                                  AppliedJobListEvent(
                                      jobId: widget.jobPosModel!.id.toString(),
                                      status: "denied"));
                            }
                          },
                          tabs: [
                            Tab(text: "Denied"),
                            Tab(text: "Message"),
                          ],
                        ),
                        Expanded(
                            child: TabBarView(children: [
                          if (appliedState is AppliedJobLoaded) ...[
                            ListView.builder(
                                itemCount: appliedState.appliedJobList.length,
                                itemBuilder: (c, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10),
                                    child: CandidateTile(
                                      idDeny: true,
                                      appliedJobModel:
                                          appliedState.appliedJobList[i],
                                    ),
                                  );
                                }),
                          ],
                          if (appliedState is ApplyLoading) ...[
                            Center(child: CircularProgressIndicator())
                          ],
                          if (appliedState is ApplyErrorState) ...[
                            Center(child: Text(appliedState.error))
                          ],
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (c, i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: MessageTile(),
                              );
                            },
                          ),
                        ]))
                      ],
                    ));
              }),
            )
            // ImageButton(image: ,)
          ],
        ));
  }
}

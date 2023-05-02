// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_state.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/denied_candidate_tile.dart';

import '../../../../../utils/app_routes.dart';
import '../../../../../utils/my_images.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button/custom_img_button.dart';
import '../../../../../widgets/custom_cards/notifications_tile/message_tile.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            leadingImage: MyImages.backArrow,
            onTap: () {
              // AppRoutes.push(
              //     context,
              //     JobPositionScreen(
              //         companyModel: companyModel, jobPosModel: jobPosModel));
              // context.read<BottomBloc>().add(SetScreenEvent(true,
              //     screenName: JobPositionScreen(
              //         companyModel: companyModel, jobPosModel: jobPosModel)));
              AppRoutes.pop(context);
            },
            centerTitle: false,
            title: "Search",
            actions: Row(
              children: [
                ImageButton(
                  image: MyImages.searchBlue,
                ),
                BlocBuilder<GlobalCubit, InitialState>(
                    builder: (context, state) {
                  var tab = context.read<GlobalCubit>();
                  return ImageButton(
                    onTap: () {
                      tab.changeTabValue(4);
                      AppRoutes.push(context, SearchTrash());
                    },
                    image: MyImages.delete,
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
                          unselectedLabelColor: MyColors.tabClr,
                          onTap: (val) {
                            tab.changeTabValue(val);
                          },
                          tabs: [
                            Tab(text: "Applied"),
                            Tab(text: "Shortlisted"),
                            Tab(text: "Messages"),
                          ],
                        );
                      }),
                      Expanded(
                          child: TabBarView(children: [
                        ListView.builder(
                            itemCount: 7,
                            itemBuilder: (c, i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: DeniedCandidateTile(),
                              );
                            }),
                        ListView.builder(
                            itemCount: 7,
                            itemBuilder: (c, i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: DeniedCandidateTile(),
                              );
                            }),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: MessageTile(),
                            );
                          },
                        ),
                      ]))
                    ],
                  )),
            )
            // ImageButton(image: ,)
          ],
        ));
  }
}

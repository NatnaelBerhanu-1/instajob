// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/job_position/job_poision_bloc.dart';
import 'package:insta_job/bloc/job_position/job_pos_event.dart';
import 'package:insta_job/model/company_model.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';

import '../utils/my_images.dart';

class AppliedSuccessDialog extends StatelessWidget {
  final bool isCoverLetter;
  final CompanyModel? companyModel;
  const AppliedSuccessDialog({Key? key, this.isCoverLetter = false, this.companyModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: MyColors.white,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(MyImages.resume),
            SizedBox(height: 20),
            CommonText(
              text: "Job Successfully Applied",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20),
            CustomButton(
              title: "Thanks!",
              onTap: () {
                //TODO: add onSuccess or similar function to this widget instead
                context.read<GlobalCubit>().changeIndex(1);
                // context.read<JobPositionBloc>().add(LoadJobPosListEvent());
                var companyId = companyModel?.id != null ? companyModel!.id.toString() : null;
                if (companyId != null) {
                  context.read<JobPositionBloc>().add(LoadJobPosListEvent(
                        companyId: companyId,
                      ));
                } else {
                  context.read<JobPositionBloc>().add(LoadJobPosListEvent());
                }
                Navigator.of(context).popUntil((route) => route.isFirst);

                // context.read<JobPositionBloc>().add(LoadJobPosListEvent());
                // AppRoutes.pushReplacement(
                //     context,
                //     JobPositionScreen(
                //       companyModel: context.read<CompanyBloc>().companyModel,
                //       jobPosModel: context.read<JobPositionBloc>().jobModel,
                //     ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

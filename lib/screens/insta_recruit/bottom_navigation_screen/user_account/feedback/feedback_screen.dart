// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_bloc.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_event.dart';
import 'package:insta_job/bloc/feedback_bloc/feedback_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

import '../../../../../utils/my_colors.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button/custom_btn.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final TextEditingController msg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Feedback",
              leadingImage: MyImages.arrowBlueLeft,
              height: 17,
              width: 17,
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: BlocConsumer<FeedBackAndAutoMsgBloc, FeedBackState>(
                listener: (c, state) {
              if (state is ErrorState) {
                showToast(state.error);
              }
              // if (state is FeedBackLoaded) {
              //   AppRoutes.pop(context);
              // }
            }, builder: (context, state) {
              return Column(
                children: [
                  CustomTextField(
                    controller: msg,
                    hint: "Message....",
                    maxLine: 10,
                  ),
                  SizedBox(height: 40),
                  CustomIconButton(
                    image: MyImages.arrowWhite,
                    title: "Leave Feedback",
                    backgroundColor: MyColors.blue,
                    fontColor: MyColors.white,
                    loading: state is FeedBackLoading ? true : false,
                    iconColor: MyColors.blue,
                    onclick: () {
                      if (msg.text.isNotEmpty) {
                        context
                            .read<FeedBackAndAutoMsgBloc>()
                            .add(InsertFeedBackEvent(msg.text));
                      } else {
                        showToast("Please enter feedback");
                      }
                      msg.clear();
                      print('ADDDDD ****************');
                    },
                  ),
                ],
              );
            }),
          ),
        ));
  }
}

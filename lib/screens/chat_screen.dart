// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/auth_service.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/dialog/time_picker_dilaog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  final JobPosModel? jobPosModel;
  final String? oppId;
  final String? selfId;
  ChatScreen({Key? key, this.jobPosModel, this.oppId, this.selfId})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msg = TextEditingController();
  String? gp;

  generateGroupId() {
    if (widget.selfId == widget.oppId) {
      gp = "${widget.oppId}_${widget.selfId}";
      print("IFFFFFFFFFF $gp");
    } else {
      gp = "${widget.selfId}_${widget.oppId}";
      print("ELSEEEEEEEEE $gp");
    }
  }

  @override
  void initState() {
    generateGroupId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: Size.fromHeight(kToolbarHeight),
      //     child: CustomAppBar()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 10, top: 10, bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Image.asset(
                              MyImages.backArrow,
                              height: 40,
                              width: 35,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CircleAvatar(
                                      radius: 24,
                                      backgroundImage: CachedNetworkImageProvider(
                                          "${EndPoint.imageBaseUrl}${widget.jobPosModel?.uploadPhoto}")),
                                )),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: "${widget.jobPosModel?.userName}",
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  CommonText(
                                    text: "Active",
                                    fontColor: MyColors.greyTxt,
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Global.userModel?.type == "user"
                          ? SizedBox()
                          : Expanded(
                              child: CustomCommonCard(
                                onTap: () {
                                  buildDialog(context, PickTimeDialog());
                                },
                                borderRadius: BorderRadius.circular(20),
                                borderColor: MyColors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonText(
                                          text: "Set up interview  ",
                                          fontColor: MyColors.blue,
                                          fontSize: 14),
                                      Icon(Icons.call, color: MyColors.blue),
                                    ],
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10, left: 12),
                  child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (c, i) {
                        return Text("");
                      }),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10, left: 12),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: IconTextField(
                      controller: msg,
                      // color: MyColors.lightGrey,
                      prefixIcon: Icon(Icons.mic),
                      color: MyColors.lightGrey,
                      borderRadius: 25,
                      hint: "Write message here..",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (msg.text.isNotEmpty) {
                            // AuthService.insertMsg(
                            //   gp: '',
                            //   msg: msg.text,
                            //   oppId: '',
                            //   selfId: '',
                            // );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Container(
                            // alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: MyColors.blue,
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13.5, horizontal: 18),
                              child: CommonText(
                                text: "Send",
                                fontColor: MyColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

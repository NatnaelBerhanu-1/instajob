// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/auth_service.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/dialog/time_picker_dilaog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/job_position_model.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/pick_interview_time_slot_screen/pick_interview_time_slot_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  final JobPosModel? jobPosModel;
  final String? oppId;
  final String? selfId;
  const ChatScreen({Key? key, this.jobPosModel, this.oppId, this.selfId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msg = TextEditingController();
  String? gp;

  generateGroupId() {
    print("OPPOSITE ID:  ${widget.oppId}");
    print("SELF ID    :  ${widget.selfId}");

    if (widget.selfId == widget.jobPosModel?.userFirebaseId) {
      gp = "${widget.oppId}_${widget.selfId}";
      setState(() {});
      print("IFFFFFFFFFF $gp");
    } else {
      gp = "${widget.selfId}_${widget.oppId}";
      setState(() {});
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
                  padding: const EdgeInsets.only(right: 10, top: 10, bottom: 15),
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
                                    text: Global.userModel?.type == "user"
                                        ? "${widget.jobPosModel?.empName}"
                                        : "${widget.jobPosModel?.userName}",
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
                                  // buildDialog(
                                  //     context,
                                  //     PickTimeDialog(
                                  //         jobPosModel: widget.jobPosModel));
                                  AppRoutes.push(context, BookSlotScreen(jobPosModel: widget.jobPosModel));
                                },
                                borderRadius: BorderRadius.circular(20),
                                borderColor: MyColors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonText(text: "Set up interview  ", fontColor: MyColors.blue, fontSize: 14),
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
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(AuthService.chatCollection)
                          .doc(gp!)
                          .collection(gp!)
                          .orderBy('time', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: ListView.builder(
                                    reverse: true,
                                    // shrinkWrap: true,
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (c, i) {
                                      var data = snapshot.data?.docs[i];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: Align(
                                          alignment: Global.userModel?.firebaseId == data?['selfId']
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: DecoratedBox(
                                            // chat bubble decoration
                                            decoration: BoxDecoration(
                                              color: Global.userModel?.firebaseId == data?['selfId']
                                                  ? MyColors.lightBlue.withOpacity(.25)
                                                  : MyColors.lightGrey,
                                              borderRadius: Global.userModel?.firebaseId == data?['selfId']
                                                  ? BorderRadius.only(
                                                      topLeft: Radius.circular(15),
                                                      topRight: Radius.circular(15),
                                                      bottomLeft: Radius.circular(15),
                                                    )
                                                  : BorderRadius.only(
                                                      topLeft: Radius.circular(15),
                                                      topRight: Radius.circular(15),
                                                      bottomRight: Radius.circular(15),
                                                    ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Text(
                                                "${data?['msg']}",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : SizedBox();
                      }),
                ),
              ),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10, left: 12),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: IconTextField(
                      controller: msg,
                      textCapitalization: TextCapitalization.sentences,
                      // color: MyColors.lightGrey,
                      prefixIcon: Icon(Icons.mic),
                      color: MyColors.lightGrey,
                      borderRadius: 25,
                      hint: "Write message here..",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (msg.text.isNotEmpty) {
                            AuthService.insertMsg(
                                gp: gp!,
                                msg: msg.text,
                                oppId: widget.oppId,
                                selfId: widget.selfId,
                                jobId: widget.jobPosModel!.jobId);
                            msg.clear();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Container(
                            // alignment: Alignment.center,
                            decoration: BoxDecoration(color: MyColors.blue, borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 18),
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

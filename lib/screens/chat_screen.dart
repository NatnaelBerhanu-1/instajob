// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/auth_service.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/chat_model.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/pick_interview_time_slot_screen/pick_interview_time_slot_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel chatModel;
  const ChatScreen({
    Key? key,
    required this.chatModel,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msg = TextEditingController();
  String? gp;

  generateGroupId() {
    gp = widget.chatModel.gp;
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
                                      backgroundImage: CachedNetworkImageProvider(Global.userModel?.type == "user"
                                          ? "${widget.chatModel.selfProfilePic}"
                                          : "${widget.chatModel.oppProfilePic}")),
                                )),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: Global.userModel?.type == "user"
                                        ? "${widget.chatModel.selfName}"
                                        : "${widget.chatModel.oppName}",
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
                                  AppRoutes.push(
                                      context,
                                      BookSlotScreen(
                                        companyId: widget.chatModel.companyId.toString(),
                                        jobId: widget.chatModel.jobId.toString(),
                                        userId: widget.chatModel.userId.toString(),
                                      ));
                                },
                                borderRadius: BorderRadius.circular(20),
                                borderColor: MyColors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonText(
                                          text: "Set up interview  ", fontColor: MyColors.blue, fontSize: 14),
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
                        debugPrint('data: ${snapshot.data?.docs.map((e) => e.data())}');
                        if (snapshot.hasData) {
                          _checkAndClearUnreadCount();
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ListView.separated(
                                reverse: true,
                                // shrinkWrap: true,
                                itemCount: snapshot.data?.docs.length ?? 0,
                                separatorBuilder: (c, i) {
                                  var len = snapshot.data?.docs.length ?? 0;
                                  // debugPrint("[LOG] i $i len $len");
                                  var currData = snapshot.data?.docs[i];
                                  var prevInTimeData = snapshot.data?.docs[i + 1];
                                  var currDate = (currData?['time'] as Timestamp).toDate().toLocal();
                                  var prevInTimeDate = (prevInTimeData?['time'] as Timestamp).toDate().toLocal();
                                  Widget separatorWidget = SizedBox.shrink();
                                  if (!isSameDate(currDate, prevInTimeDate)) {
                                    separatorWidget =
                                        Center(child: Text(DateFormat.yMMMd().format(currDate!).toString()));
                                  }
                                  return separatorWidget;
                                },
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
                                          child: Column(
                                            children: [
                                              Text(
                                                "${data?['msg']}",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              SizedBox(height: 4.0),
                                              Text(
                                                DateFormat.Hm()
                                                    .format((data?['time'] as Timestamp).toDate().toLocal()),
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }
                        return SizedBox();
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
                            debugPrint(
                                'chatModel(abt to send msg, without msg text): ${widget.chatModel.toJson()}');
                            AuthService.insertMsg(widget.chatModel.copyWith(msg: msg.text),
                                isUser: Global.userModel?.type == 'user');
                            msg.clear();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Container(
                            // alignment: Alignment.center,
                            decoration:
                                BoxDecoration(color: MyColors.blue, borderRadius: BorderRadius.circular(25)),
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
              )
      ),
    );
  }

  bool isSameDate(DateTime? date1, DateTime date2) {
    return date1 != null && date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  _checkAndClearUnreadCount() async {
    var documentSnapshot = await FirebaseFirestore.instance.collection(AuthService.chatCollection).doc(gp!).get();
    var data = documentSnapshot.data();
    debugPrint('Data:$data');
    if (data != null) {
      bool isUser = Global.userModel?.type == "user";
      var oppUnread = data['oppUnreadCount'];
      var selfUnread = data['selfUnreadCount'];
      debugPrint('oppUnread:$oppUnread, selfUnread:$selfUnread');
      if (isUser && oppUnread != null && oppUnread != 0) {
        await FirebaseFirestore.instance.collection(AuthService.chatCollection).doc(gp!).update({'oppUnreadCount': 0});
      } else if (!isUser && selfUnread != null && selfUnread != 0) {
        await FirebaseFirestore.instance.collection(AuthService.chatCollection).doc(gp!).update({'selfUnreadCount': 0});
      }
    }
  }
}

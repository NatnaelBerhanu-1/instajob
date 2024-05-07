// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:insta_job/auth_service.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/chat_model.dart';
import 'package:insta_job/screens/chat_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_divider.dart';

import '../../../utils/my_images.dart';

class MessageTile extends StatelessWidget {
  final ChatModel chatModel;
  const MessageTile({Key? key, required this.chatModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection(AuthService.chatCollection).doc(chatModel.gp).snapshots(),
        builder: (context1, snapshot1) {
          if (!snapshot1.hasData) {
            return SizedBox.shrink();
            // return Text("NO DATA");
          }
          var updatedChatModelAsMap = snapshot1.data?.data();
          ChatModel updatedChatModel = ChatModel.fromMap(updatedChatModelAsMap as Map<String, dynamic>);
          int? unreadCount =
              Global.userModel?.type == "user" ? updatedChatModel.oppUnreadCount : updatedChatModel.selfUnreadCount;
          return GestureDetector(
            onTap: () {
              AppRoutes.push(context, ChatScreen(chatModel: updatedChatModel));
            },
            child: Slidable(
              endActionPane: ActionPane(motion: ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (val) {
                    AuthService.deleteChat(updatedChatModel);
                  },
                  icon: Icons.delete_outline,
                  label: "",
                  backgroundColor: MyColors.darkRed,
                )
              ]),
              direction: Axis.horizontal,
              child: Column(
                children: [
                  CustomCommonCard(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                      radius: 20,
                                      backgroundImage: CachedNetworkImageProvider(
                                          "${Global.userModel?.type == "user" ? updatedChatModel.selfProfilePic : updatedChatModel.oppProfilePic}")),
                                  Positioned(
                                      bottom: 5,
                                      left: 67,
                                      child: Container(
                                        padding: EdgeInsets.all(3.5),
                                        decoration: BoxDecoration(color: MyColors.blue, shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 13,
                                          color: MyColors.blue,
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    // text: "${updatedChatModel.oppName}",
                                    text: Global.userModel?.type == "user"
                                        ? "${updatedChatModel.selfName}"
                                        : "${updatedChatModel.oppName}",
                                    fontWeight: FontWeight.w500,
                                  ),
                                  CommonText(
                                    text: "1 Minute ago",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                                ],
                              ),
                              Spacer(),
                              if ((unreadCount ?? 0) > 0)
                                Container(
                                  height: 25,
                                  width: 25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyColors.blue,
                                  ),
                                  child: CommonText(
                                    // text: "1",
                                    text: (unreadCount ?? 0).toString(),
                                    fontWeight: FontWeight.w400,
                                    fontColor: MyColors.white,
                                    fontSize: 13,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: MyColors.lightGreen,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CommonText(
                                    text: "${updatedChatModel.oppTitle}",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    fontColor: MyColors.green,
                                  ),
                                  SizedBox(width: 10),
                                  ImageButton(
                                    image: MyImages.cancelGreen,
                                    padding: EdgeInsets.zero,
                                    height: 17,
                                    width: 17,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  divider()
                ],
              ),
            ),
          );
        });
  }
}

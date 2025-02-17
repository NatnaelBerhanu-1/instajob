import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/chat_model.dart';

class AuthService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static const chatCollection = 'chat';
  static const userCollection = 'user';

  static Future<void> insertMsg(ChatModel chatModel) async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    var chatRef = FirebaseFirestore.instance.collection(chatCollection).doc(chatModel.gp);
    var docRef = chatRef.collection(chatModel.gp).doc(DateTime.now().millisecondsSinceEpoch.toString());

    var data = chatModel.getMessageData();

    var chatData = chatModel.getChatData();

    debugPrint('Chat: ${chatModel.toJson()}');

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(chatRef, chatData);
      transaction.set(docRef, data);
    });
    // var doc = await db.collection("recentChatUser").doc(selfId).get();
    // if (doc.exists) {
    //   print("EXISTS");
    //   await db
    //       .collection("recentChatUser")
    //       .doc(selfId)
    //       .collection("users")
    //       .doc(oppId)
    //       .update({
    //     "phone_number": oppId,
    //     "user_name": userName,
    //     "profile": profile,
    //     "fcm_token": fcmToken,
    //   });
    // } else {
    //   print("NOT EXISTS");
    //   await db
    //       .collection("recentChatUser")
    //       .doc(selfId)
    //       .collection("users")
    //       .doc(oppId)
    //       .set({
    //     "phone_number": oppId,
    //     "user_name": userName,
    //     "profile": profile,
    //     "fcm_token": fcmToken,
    //   });
    // }
  }

  static insertUsers() async {
    final ref = await FirebaseFirestore.instance.collection(userCollection).doc(Global.userModel?.firebaseId).get();
    if (ref.exists) {
      print('ALREADY EXIST');
      return db.collection(userCollection).doc(Global.userModel?.firebaseId).update({
        "userId": FirebaseAuth.instance.currentUser?.uid,
        "name": Global.userModel?.name,
        "profile": Global.userModel?.uploadPhoto,
      });
    } else {
      print('NEW USER');
      return db.collection(userCollection).doc(Global.userModel?.firebaseId).set({
        "userId": FirebaseAuth.instance.currentUser?.uid,
        "name": Global.userModel?.name,
        "profile": Global.userModel?.uploadPhoto,
      });
    }
  }
}

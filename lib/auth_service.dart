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

  static Future<void> insertMsg(ChatModel chatModel, {bool isUser = false}) async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    var chatRef = FirebaseFirestore.instance.collection(chatCollection).doc(chatModel.gp);
    var docRef = chatRef.collection(chatModel.gp).doc(DateTime.now().millisecondsSinceEpoch.toString());

    var data = isUser
        ? chatModel.copyWith(oppId: chatModel.selfId, selfId: chatModel.oppId).getMessageData()
        : chatModel.getMessageData();
      
    // var data = isUser
    //   ? chatModel.copyWith(oppId: chatModel.selfId, selfId: chatModel.oppId, oppUnreadCount: chatModel.oppUnreadCount ?? 0 + 1).getMessageData()
    //   : chatModel.copyWith(selfUnreadCount: chatModel.selfUnreadCount ?? 0 + 1).getMessageData();

    var chatData;
    if (isUser) {
      chatData = chatModel.copyWith(oppUnreadCount: (chatModel.oppUnreadCount ?? 0) + 1).getChatData();
    } else { 
      chatData = chatModel.copyWith(selfUnreadCount: (chatModel.selfUnreadCount ?? 0) + 1).getChatData();
    }
    // var chatData = chatModel.getChatData();

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

  static Future<void> deleteChat(ChatModel chatModel) async {
    // var fcmToken = await FirebaseMessaging.instance.getToken();
    var chatRef = FirebaseFirestore.instance.collection(chatCollection).doc(chatModel.gp);
    // var docRef = chatRef.collection(chatModel.gp).doc(DateTime.now().millisecondsSinceEpoch.toString());

     // Get all documents in the subcollection
    var subcollectionSnapshot = await chatRef.collection(chatModel.gp).get();
    
    // Delete each document in the subcollection
    for (var doc in subcollectionSnapshot.docs) {
      await doc.reference.delete();
    }

    // Delete the parent document
    await chatRef.delete();

  }

  //untested
  static Future<void> updateUnreadCount(ChatModel updatedChatModel, {bool isUser = false}) async {
    var chatRef = FirebaseFirestore.instance.collection(chatCollection).doc(updatedChatModel.gp);

    debugPrint('Chat: ${updatedChatModel.toJson()}');

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(chatRef, updatedChatModel);
    });
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

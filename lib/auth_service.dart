import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_job/globals.dart';

class AuthService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static const chatCollection = 'chat';
  static const userCollection = 'user';

  static Future<void> insertMsg({
    String? oppId,
    String? selfId,
    required String gp,
    String? msg,
  }) async {
    var docRef = FirebaseFirestore.instance
        .collection(chatCollection)
        .doc(gp)
        .collection(gp)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    var data = {
      "oppId": oppId,
      "selfId": selfId,
      "group": gp,
      "msg": msg,
      "time": FieldValue.serverTimestamp(),
    };

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(docRef, data);
    });
  }

  static insertUsers() async {
    final ref = await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(Global.userModel?.firebaseId)
        .get();
    if (ref.exists) {
      print('ALREADY EXIST');
      return db
          .collection(userCollection)
          .doc(Global.userModel?.firebaseId)
          .update({
        "userId": FirebaseAuth.instance.currentUser?.uid,
        "name": Global.userModel?.name,
        "profile": Global.userModel?.uploadPhoto,
      });
    } else {
      print('NEW USER');
      return db
          .collection(userCollection)
          .doc(Global.userModel?.firebaseId)
          .set({
        "userId": FirebaseAuth.instance.currentUser?.uid,
        "name": Global.userModel?.name,
        "profile": Global.userModel?.uploadPhoto,
      });
    }
  }
}

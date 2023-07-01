import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static const chatCollection = 'chat';

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
      "time": DateTime.now(),
      "createdAt": FieldValue.serverTimestamp()
    };

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(docRef, data);
    });
  }
}

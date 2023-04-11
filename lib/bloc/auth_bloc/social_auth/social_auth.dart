import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/globals.dart';

class SocialAuth {
  /// email
  static FirebaseAuth auth = FirebaseAuth.instance;
  static emailAndPass(BuildContext context,
      {required String email,
      required String password,
      required String name,
      bool isUser = false}) {
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      context.read<AuthCubit>().registerEmp(
          email: email, password: password, name: name, isUser: isUser);
    }).catchError((e) {
      showToast(e.message);
      print("7777777777777777777777777 ${e.message}");
    });
  }

  static loginWithEmail(BuildContext context,
      {required String email, required String password, bool isUser = false}) {
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      context
          .read<AuthCubit>()
          .login(email: email, password: password, isUser: isUser);
    }).catchError((e) {
      showToast(e.message);
    });
  }
}

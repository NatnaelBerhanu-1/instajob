import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/globals.dart';

class SocialAuth {
  /// email
  static FirebaseAuth auth = FirebaseAuth.instance;
  static emailAndPass(BuildContext context,
      {
      //   required String email,
      // required String password,
      // required String name,
      // String? date,
      // String? profilePic,
      // String? phoneNumber,
      bool isUser = false}) {
    var data = context.read<AuthCubit>();
    auth
        .createUserWithEmailAndPassword(
            email: data.email, password: data.password)
        .then((value) {
      context.read<AuthCubit>().registerData(isUser: isUser);
      context.read<GlobalCubit>().changeIndex(1);
      print(" @@@@@@ ${context.read<GlobalCubit>().sIndex}");
      // context.read<CompanyBloc>().add(LoadCompanyListEvent());
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
      print("QQQQQQQQQQQQQQQQQQQQQQQQ $isUser");
      context
          .read<AuthCubit>()
          .login(email: email, password: password, isUser: isUser);
      context.read<GlobalCubit>().changeIndex(1);
      print(" @@@@@@ ${context.read<GlobalCubit>().sIndex}");
      // context.read<CompanyBloc>().add(LoadCompanyListEvent());
    }).catchError((e) {
      print("!!!!!! ${e.code}");
      switch (e.code) {
        case "user-not-found":
          showToast("User does not exist, Please Register first");
          break;
        case "wrong-password":
          showToast("Invalid email and password");
          break;
        case "too-many-request":
          showToast("Try it after few minutes");
      }
    });
  }
}

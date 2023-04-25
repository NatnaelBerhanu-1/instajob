import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/user_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/auth_repository.dart';
import 'package:insta_job/screens/auth_screen/login_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/membership_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../company_bloc/company_bloc.dart';

class AuthCubit extends Cubit<AuthInitialState> {
  final SharedPreferences sharedPreferences;
  final AuthRepository authRepository;
  final CompanyBloc companyBloc;

  AuthCubit(this.companyBloc,
      {required this.sharedPreferences, required this.authRepository})
      : super(AuthInitialState());

  registerEmp({
    String? name,
    String? email,
    String? password,
    bool isUser = false,
  }) async {
    print("3333333333333333333333333333333333333333");
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.empRegister(
        name: name, email: email, password: password, isUser: isUser);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      // loading(value: true);
      await sharedPreferences.setString(
          "user", jsonEncode(response.response.data['data']));
      var userModel = UserModel.fromJson(response.response.data['data']);
      Global.userModel = userModel;
      emit(AuthState(userModel: userModel));
      companyBloc.add(LoadCompanyListEvent());

      var agree = sharedPreferences.getBool('isAgree');
      if (agree == true) {
        navigationKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const BottomNavScreen()),
            (route) => false);
      } else {
        navigationKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => const MemberShipScreen(isAgreement: true)),
            (route) => false);
      }
    } else {
      emit(ErrorState("Something went wrong"));
    }
  }

  login({
    String? email,
    String? password,
    bool isUser = false,
  }) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.empLogin(
        email: email, password: password, isUser: isUser);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      await sharedPreferences.setString(
          "user", jsonEncode(response.response.data['data']));
      var userModel = UserModel.fromJson(response.response.data['data']);
      Global.userModel = userModel;
      print('user ----------        ${userModel.id}  ');
      emit(AuthState(userModel: userModel));
      companyBloc.add(LoadCompanyListEvent());

      navigationKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const BottomNavScreen()),
          (route) => false);
    }
    if (response.response.statusCode == 400) {
      emit(ErrorState("${response.response.data['message']}"));
    }
  }

  /// google auth
  googleAuth({
    bool isUser = false,
  }) async {
    loading(value: true);
    GoogleSignIn googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    try {
      loading(value: false);

      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        if (value.user != null) {
          ApiResponse response =
              await authRepository.checkUser(value.user!.email.toString());
          if (response.response.statusCode == 200) {
            login(
                email: value.user!.email,
                isUser: isUser,
                password: value.user!.uid);
          } else {
            registerEmp(
              email: value.user!.email,
              isUser: isUser,
              password: value.user!.uid,
              name: value.user!.displayName,
            );
          }
          // var userModel = UserModel.fromJson(response.response.data['data']);
          // Global.userModel = userModel;
          // await sharedPreferences.setString(
          //     "user", jsonEncode(response.response.data['data']));
          // emit(AuthState(userModel: userModel));
          navigationKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const BottomNavScreen()),
              (route) => false);
          print('USERRRR ------------------           ${value.user}');
        }
      });
    } catch (e) {
      loading(value: false);
      print(
          "####################################################################");
      print(e.toString());
      emit(ErrorState(e.toString()));
    }
  }

  /// facebook
  faceBookAuth() async {
    final LoginResult loginResult =
        await FacebookAuth.instance.login(permissions: ['email']);

    try {
      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final OAuthCredential facebookCredential =
            FacebookAuthProvider.credential(accessToken.token);
        FirebaseAuth.instance
            .signInWithCredential(facebookCredential)
            .then((value) {
          print('THENN ');
          if (value.user != null) {
            navigationKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const BottomNavScreen()),
                (route) => false);
          }
        });
      } else {
        print('TOKENN ----------          ');
      }
    } on FirebaseAuthException catch (e) {
      print('EEEEEEEEEEEEEEEEEEEEE ${e.message}');

      emit(ErrorState(e.toString()));
    }
  }

  ///logout
  logOut() async {
    ApiResponse response = await authRepository.logOutUser();
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      await sharedPreferences.remove("user");
      await FirebaseAuth.instance.signOut();
      navigationKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false);
    } else {
      emit(ErrorState("Somthing went wrong"));
    }
  }
}

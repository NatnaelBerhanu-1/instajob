import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
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
  final BottomBloc user;

  AuthCubit(this.companyBloc, this.user,
      {required this.sharedPreferences, required this.authRepository})
      : super(AuthInitialState());
  String userName = "";
  String companyName = "";
  String email = "";
  String password = "";
  String website = "";
  String phoneNumber = "";
  String profilePic = "";
  String cv = "";
  String dob = "";

  getData() {
    print("userName: $userName");
    print("email: $email");
    print("password: $password");
    print("phoneNumber: $phoneNumber");
    print("profilePic: $profilePic");
    print("website: $website");
    print("cv: $cv");
  }

  registerEmp({bool isUser = false}) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.empRegister(
        name: userName,
        email: email,
        password: password,
        isUser: isUser,
        phoneNumber: phoneNumber,
        profilePic: profilePic,
        date: dob,
        companyName: companyName,
        cv: cv,
        websiteLink: website);
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

  /// UPDATE USER
  updateUserData({
    String? name,
    String? phoneNumber,
    String? profilePhoto,
    String? dOB,
  }) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.updateUser(
      phoneNumber: phoneNumber,
      name: name,
      dOB: dOB,
      profilePhoto: profilePhoto,
    );
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      await sharedPreferences.setString(
          "user", jsonEncode(response.response.data['data']));
      var userModel = UserModel.fromJson(response.response.data['data']);
      Global.userModel = userModel;
      emit(AuthState(userModel: userModel));
      navigationKey.currentState?.pop();
      navigationKey.currentState?.pop();
      user.add(UserEvent());
    }
    if (response.response.statusCode == 400) {
      emit(ErrorState("${response.response.data['message']}"));
    }
  }

  /// EMPLOYEE UPDATE
  updateEmpData({
    String? name,
    String? phoneNumber,
    String? profilePhoto,
  }) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.updateEmp(
      phoneNumber: phoneNumber,
      companyName: name,
      profilePhoto: profilePhoto,
    );
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      await sharedPreferences.setString(
          "user", jsonEncode(response.response.data['data']));
      var userModel = UserModel.fromJson(response.response.data['data']);
      Global.userModel = userModel;
      emit(AuthState(userModel: userModel));
      navigationKey.currentState?.pop();
      navigationKey.currentState?.pop();
      user.add(UserEvent());
    }
    if (response.response.statusCode == 400) {
      emit(ErrorState("${response.response.data['message']}"));
    }
  }

  /// google auth
  bool isGoogleSignIn = false;
  googleAuth({
    bool isUser = false,
  }) async {
    loading(value: true);
    GoogleSignIn googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    try {
      loading(value: false);
      isGoogleSignIn = true;
      emit(AuthInitialState());
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
              // email: value.user!.email,
              isUser: isUser,
              // password: value.user!.uid,
              // name: value.user!.displayName,
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
    GoogleSignIn googleSignIn = GoogleSignIn();

    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      await sharedPreferences.remove("user");
      await FirebaseAuth.instance.signOut();
      if (isGoogleSignIn) {
        await googleSignIn.disconnect();
      }
      user.add(ResetIndex());
      navigationKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false);
    } else {
      emit(ErrorState("Something went wrong"));
    }
  }
}

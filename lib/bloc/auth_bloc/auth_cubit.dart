import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/user_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/auth_repository.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthInitialState> {
  final SharedPreferences sharedPreferences;
  final AuthRepository authRepository;
  AuthCubit({required this.sharedPreferences, required this.authRepository})
      : super(AuthInitialState());
  late UserModel userModel;
  storeData(UserModel u) {
    userModel = u;
    emit(AuthState(userModel: userModel));
  }

  registerEmp({
    String? name,
    String? email,
    String? password,
  }) async {
    ApiResponse response = await authRepository.registerEmp(
        name: name, email: email, password: password);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Somthing went wrong"));
    }
    if (response.response.statusCode == 200) {
      // loading(value: true);
      userModel = UserModel.fromJson(response.response.data['data']);
      await sharedPreferences.setString(
          "user", jsonEncode(response.response.data['data']));
      emit(AuthState(userModel: userModel));
      navigationKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const BottomNavigationScreen()),
          (route) => false);
    } else {
      emit(ErrorState("Somthing went wrong"));
    }
  }
}

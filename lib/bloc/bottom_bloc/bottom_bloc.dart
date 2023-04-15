import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import '../../screens/insta_recruit/user_type_screen.dart';

class BottomBloc extends Bloc<BottomEvent, BottomInitialState> {
  int currentIndex = 0;
  bool selectScreen = false;
  var screenNameVal;

  /// Implementation of event , bloc

  BottomBloc() : super(BottomInitialState()) {
    /// bottom navigation Index change

    on<GetIndexEvent>((event, emit) {
      currentIndex = event.index;
      emit(BottomNavIndexState(event.index));
    });

    /// set Screen

    on<SetScreenEvent>((event, emit) {
      selectScreen = event.value;
      screenNameVal = event.screenName;
      emit(SetScreenBottomNavState());
    });

    /// check User

    on<UserEvent>((event, emit) async {
      final currentUser = FirebaseAuth.instance.currentUser;
      var pref = await SharedPreferences.getInstance();
      if (currentUser != null) {
        var user = await jsonDecode(pref.getString("user").toString());
        UserModel userModel = UserModel.fromJson(user);
        Global.userModel = userModel;
        print('USERMODEL ---------------        $user');
        Timer(
            Duration(seconds: 1),
            () => navigationKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const BottomNavScreen()),
                (route) => false));
        emit(UserState(userModel));
      } else {
        Timer(
            const Duration(seconds: 1),
            () => navigationKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const UserTypeScreen()),
                (route) => false));
      }
    });
  }
  // getIndex(value) {
  //   currentIndex = value;
  //   emit(BottomNavIndexState(value));
  // }

  // setSelectedScreen(value, {Widget? screenName}) {
  //   print(screenName);
  //   selectScreen = value;
  //   screenNameVal = screenName;
  //   emit(SetScreenBottomNavState(value, screenName ?? Container()));
  // }

  // void resetIndex() {
  //   currentIndex = 0;
  //   selectScreen = false;
  //   emit(BottomNavIndexState(0));
  // }
}

/// bloc state

class BottomInitialState {}

class BottomNavIndexState extends BottomInitialState {
  final int index;

  BottomNavIndexState(this.index);
}

class SetScreenBottomNavState extends BottomInitialState {
  // final bool value;
  // final Widget screen;

  // SetScreenBottomNavState(this.value, this.screen);
}

class UserState extends BottomInitialState {
  final UserModel userModel;

  UserState(this.userModel);
}

/// bloc event

class BottomEvent {}

class GetIndexEvent extends BottomEvent {
  final int index;

  GetIndexEvent(this.index);
}

class SetScreenEvent extends BottomEvent {
  final value;
  final Widget? screenName;

  SetScreenEvent(this.value, {this.screenName});
}

class UserEvent extends BottomEvent {}

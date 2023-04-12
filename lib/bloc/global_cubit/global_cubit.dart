import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'global_state.dart';

class GlobalCubit extends Cubit<InitialState> {
  int sIndex = 0;
  int fIndex = 0;
  GlobalCubit() : super(InitialState());

  changeIndex(index) {
    sIndex = index;
    emit(IndexState(sIndex));
  }

  changeFilterIndex(index) {
    fIndex = index;
    emit(FilterState(fIndex));
  }

  int currentIndex = 0;
  getIndex(value) {
    currentIndex = value;
    emit(BottomNavIndexState(value));
  }

  bool selectScreen = false;
  var screenNameVal;

  setSelectedScreen(value, {Widget? screenName}) {
    print(screenName);
    print('scrrreree');
    selectScreen = value;
    print("fuhf");
    screenNameVal = screenName;
    emit(SetScreenBottomNavState(value, screenName ?? Container()));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'global_state.dart';

class GlobalCubit extends Cubit<InitialState> {
  int sIndex = 1;
  int fIndex = 0;
  GlobalCubit() : super(InitialState());
  bool pass = false;
  bool cPass = false;
  bool checkBox = false;
  int selectedTab = 0;

  changeTabValue(val) {
    selectedTab = val;
    print("SELECTED TAB $selectedTab");
    emit(TabState(selectedTab));
  }

  visiblePass() {
    pass = !pass;
    emit(VisiblePassState(pass));
  }

  visibleCPass() {
    cPass = !cPass;
    emit(VisiblePassState(cPass));
  }

  checkBoxValue() {
    checkBox = !checkBox;
    emit(VisiblePassState(checkBox));
  }

  changeIndex(index) {
    sIndex = index;
    emit(IndexState(sIndex));
  }

  changeFilterIndex(index) {
    fIndex = index;
    emit(FilterState(fIndex));
  }

  /// job Type
  String jobTypeValue = "";
  jobType(String val) {
    jobTypeValue = val;
    emit(JobTypeState(jobTypeValue));
  }

  /// Experience level
  String experienceLevelVal = "";
  experienceLevel(String val) {
    experienceLevelVal = val;
    emit(JobTypeState(experienceLevelVal));
  }

  /// RangeSlider

  RangeValues rangeValue = const RangeValues(10, 30);
  rangeValues(RangeValues values) {
    rangeValue = values;
    // print("@@@@@@@@@@ |||||||  $rangeValue");
    emit(RangeValueState(rangeValue));
  }

  /// SKILLS
  List<String> skills = [];
  topSkills(skillVal) {
    skills.add(skillVal);
    emit(AddTopSkillsState(skillVal));
  }

  removeSkill(index) {
    skills.removeAt(index);
    emit(InitialState());
  }

  /// SLIDER
  double range = 10;
  rangeVal(double val) {
    range = val;
    print("RANGE: ${range.toStringAsFixed(0)}");
    emit(RangeState(range));
  }
}

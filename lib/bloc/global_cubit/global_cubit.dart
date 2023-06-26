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

  /// DROPDOWN VALUE
  String dropDownValue = "abc";
  changeDropDownValue(val) {
    dropDownValue = val;
    emit(DropDownState(dropDownValue));
  }

  /// job Type
  String jobTypeValue = "";
  jobType(String val) {
    jobTypeValue = val;
    print("JOB TYPE $jobTypeValue");
    emit(JobTypeState(jobTypeValue));
  }

  /// Filter Value
  String sortByValue = '';
  sortBy(String val) {
    sortByValue = val;
    print("SORT BY $sortByValue");
    emit(JobTypeState(sortByValue));
  }

  String last_24 = '';
  String last_14 = '';
  String last_7 = '';
  String last_3 = '';

  last24Duration(String val) {
    last_24 = val;
    print("24 $last_24");
    emit(JobTypeState(last_24));
  }

  last14Duration(String val) {
    last_14 = val;
    print("14 $last_14");
    emit(JobTypeState(last_14));
  }

  last7Duration(String val) {
    last_7 = val;
    print("7 $last_7");
    emit(JobTypeState(last_7));
  }

  last3Duration(String val) {
    last_3 = val;
    print("3 $last_3");
    emit(JobTypeState(last_3));
  }

  int durationIndex = 0;
  durationIndexChange(val) {
    durationIndex = val;
    emit(IndexState(durationIndex));
  }

  /// Resume Index
  int rIndex = 0;
  changeRIndex(val) {
    rIndex = val;
    emit(IndexState(rIndex));
  }

  /// Experience level
  String experienceLevelVal = "";
  experienceLevel(String val) {
    experienceLevelVal = val;
    print("EXPERIENCE $experienceLevelVal");
    emit(JobTypeState(experienceLevelVal));
  }

  clearValue() {
    durationIndex = 0;
    sortByValue = "";
    jobTypeValue = "";
    experienceLevelVal = "";
    range = 0;
    rangeValue = const RangeValues(0, 0);
    emit(InitialState());
  }

  /// RangeSlider

  RangeValues rangeValue = const RangeValues(0, 0);
  rangeValues(RangeValues values) {
    rangeValue = values;
    // print("@@@@@@@@@@ |||||||  $rangeValue");
    emit(RangeValueState(rangeValue));
  }

  /// SKILLS
  List<String> skills = [];
  List<String> achievementList = [];
  topSkills(skillVal) {
    skills.add(skillVal);
    emit(AddTopSkillsState(skillVal));
  }

  addAchievement(val) {
    achievementList.add(val);
    emit(AddAchievementState(val));
  }

  removeSkill(index) {
    skills.removeAt(index);
    emit(InitialState());
  }

  removeAchievement(index) {
    achievementList.removeAt(index);
    emit(InitialState());
  }

  // /// Drop Down Value
  // changeMonth() {}

  /// SLIDER
  double range = 0;
  rangeVal(double val) {
    range = val;
    print("RANGE: ${range.toStringAsFixed(0)}");
    emit(RangeState(range));
  }

  List list = [];

  onSelected(bool selected, value) {
    if (selected == true) {
      list.add(value);
      SelectedCheckBoxState(selected);
    } else {
      list.remove(value);
      emit(InitialState());
    }
  }
}

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

  String durationValue = '';
  duration(String val) {
    durationValue = val;
    print("DURATION $durationValue");
    emit(JobTypeState(durationValue));
  }

  /// Experience level
  String experienceLevelVal = "";
  experienceLevel(String val) {
    experienceLevelVal = val;
    print("EXPERIENCE $experienceLevelVal");
    emit(JobTypeState(experienceLevelVal));
  }

  /// RangeSlider

  RangeValues rangeValue = const RangeValues(0, 15);
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

  // /// Drop Down Value
  // changeMonth() {}

  /// SLIDER
  double range = 10;
  rangeVal(double val) {
    range = val;
    print("RANGE: ${range.toStringAsFixed(0)}");
    emit(RangeState(range));
  }
}

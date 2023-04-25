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

  RangeValues range = const RangeValues(10, 30);
  rangeValues(RangeValues values) {
    range = values;
    emit(RangeState(range));
  }

  List<String> skills = [];
  topSkills(skillVal) {
    skills.add(skillVal);
    emit(AddTopSkillsState(skillVal));
  }
}

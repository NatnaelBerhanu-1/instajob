import 'package:flutter/material.dart';

class InitialState {}

class IndexState extends InitialState {
  final int isSelected;

  IndexState(this.isSelected);
}

class FilterState extends InitialState {
  final int isFilterSelected;

  FilterState(this.isFilterSelected);
}

class VisiblePassState extends InitialState {
  final bool visibleValue;

  VisiblePassState(this.visibleValue);
}

class JobTypeState extends InitialState {
  final String val;

  JobTypeState(this.val);
}

class JobSourceState extends InitialState {
  final String val;

  JobSourceState(this.val);
}

class TabState extends InitialState {
  final int val;

  TabState(this.val);
}

class SelectedCheckBoxState extends InitialState {
  final bool val;

  SelectedCheckBoxState(this.val);
}

class DropDownState extends InitialState {
  final String val;

  DropDownState(this.val);
}

class RangeValueState extends InitialState {
  final RangeValues val;

  RangeValueState(this.val);
}

class RangeState extends InitialState {
  final double val;

  RangeState(this.val);
}

class AddTopSkillsState extends InitialState {
  final String skills;

  AddTopSkillsState(this.skills);
}

class AddAchievementState extends InitialState {
  final String val;

  AddAchievementState(this.val);
}

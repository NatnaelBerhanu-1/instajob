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

class ExperienceLevelState extends InitialState {
  final String val;

  ExperienceLevelState(this.val);
}

class RangeState extends InitialState {
  final RangeValues val;

  RangeState(this.val);
}

class AddTopSkillsState extends InitialState {
  final String skills;

  AddTopSkillsState(this.skills);
}

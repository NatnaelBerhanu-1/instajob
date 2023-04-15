import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBloc extends Bloc<BottomEvent, BottomInitialState> {
  int currentIndex = 0;
  bool selectScreen = false;
  var screenNameVal;
  BottomBloc() : super(BottomInitialState()) {
    on<GetIndexEvent>((event, emit) {
      currentIndex = event.index;
      emit(BottomNavIndexState(event.index));
    });
    on<SetScreenEvent>((event, emit) {
      print(event.screenName);
      selectScreen = event.value;
      screenNameVal = event.screenName;
      emit(SetScreenBottomNavState());
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

  void resetIndex() {
    currentIndex = 0;
    selectScreen = false;
    emit(BottomNavIndexState(0));
  }
}

class BottomInitialState {}

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

class BottomNavIndexState extends BottomInitialState {
  final int index;

  BottomNavIndexState(this.index);
}

class SetScreenBottomNavState extends BottomInitialState {
  // final bool value;
  // final Widget screen;

  // SetScreenBottomNavState(this.value, this.screen);
}

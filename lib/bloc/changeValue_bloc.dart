import 'package:flutter_bloc/flutter_bloc.dart';

class InitialState {}

class IndexState extends InitialState {
  final int index;

  IndexState(this.index);
}

class Event {}

class ChangeIndex extends Event {
  final int index;

  ChangeIndex(this.index);
}

class IndexBloc extends Bloc<Event, InitialState> {
  int sIndex = 0;
  IndexBloc() : super(InitialState()) {
    on<ChangeIndex>((event, emit) {
      print("object");
      sIndex = event.index;

      emit(IndexState(sIndex));
    });
  }
}

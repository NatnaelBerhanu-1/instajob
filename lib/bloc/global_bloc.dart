import 'package:flutter_bloc/flutter_bloc.dart';

class InitialState{}

class IndexState extends InitialState{
  final int isSelected;

  IndexState(this.isSelected);
}

class FilterState extends InitialState{
  final int isFilterSelected;

  FilterState(this.isFilterSelected);
}

class IndexBloc extends Cubit<InitialState> {
  int sIndex = 0;
  int fIndex = 0;
  IndexBloc() : super(InitialState());

  changeIndex(index) {
    sIndex = index;
    emit(IndexState(sIndex));
  }

  changeFilterIndex(index) {
    fIndex = index;
    emit(FilterState(fIndex));
  }


}

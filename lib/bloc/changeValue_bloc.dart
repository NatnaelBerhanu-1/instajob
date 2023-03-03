import 'package:flutter_bloc/flutter_bloc.dart';

class IndexState {
  final int isSelected;

  IndexState(this.isSelected);
}

class IndexBloc extends Cubit<IndexState> {
  int sIndex = 0;
  IndexBloc() : super(IndexState(0));

  changeIndex(index) {
    sIndex = index;
    emit(IndexState(sIndex));
  }
}

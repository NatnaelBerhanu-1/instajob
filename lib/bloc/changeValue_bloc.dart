import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class InitialState extends Equatable {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }

class IndexState extends Equatable {
  final int isSelected;

  IndexState(this.isSelected);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Event extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangeIndex extends Event {
  final int index;

  ChangeIndex(this.index);
  @override
  List<Object?> get props => [index];
}

class IndexBloc extends Bloc<Event, IndexState> {
  int sIndex = 0;
  IndexBloc() : super(IndexState(0)) {
    on<ChangeIndex>((event, emit) => (_mapSelectCategoryEventToState));
  }
}

void _mapSelectCategoryEventToState(
    ChangeIndex event, Emitter<IndexState> emit) async {
  emit(IndexState(event.index));
  // emit();
}

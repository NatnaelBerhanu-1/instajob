import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';

class ValidationCubit extends Cubit<InitialValidation> {
  ValidationCubit() : super(InitialValidation());
  bool valid = false;
  String? emailValidation(String s) {
    RegExp pattern = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    if (s.isEmpty) {
      valid = false;
      emit(RequiredValidation("Email cannot be empty"));
    } else if (!pattern.hasMatch(s)) {
      valid = false;
      emit(InvalidEmailState("Enter valid email"));
    } else {
      valid = true;
      emit(ValidState("valid"));
    }

    return null;
  }

  String? requiredValidation(String s) {
    if (s.isEmpty || s == "") {
      emit(RequiredValidation("Required *"));
    }
    emit(ValidState("valid"));
    return null;
  }

  String? passwordValidation(String s) {
    if (s.isEmpty || s == "") {
      emit(RequiredValidation("Password cannot be empty"));
    } else if (s.length < 6) {
      emit(ValidState("Password must not be less then 6 digits"));
    }
    emit(ValidState("valid"));
    return null;
  }
}

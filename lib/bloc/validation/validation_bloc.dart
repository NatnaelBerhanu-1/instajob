import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';

class ValidationCubit extends Cubit<InitialValidation> {
  ValidationCubit() : super(InitialValidation());
  bool valid = false;
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

  String? emailValidation(String s) {
    RegExp pattern = RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$');
    if (s.isEmpty) {
      valid = false;
      emit(RequiredValidation("Email cannot be empty"));
      return s;
    } else if (!pattern.hasMatch(s)) {
      valid = false;
      emit(InvalidEmailState("Enter valid email"));
      return s;
    } else {
      valid = true;
      emit(ValidState("valid"));
      // return s;
    }

    return null;
  }

  String? requiredValidation(String s, value) {
    if (s.isEmpty || s == "") {
      emit(RequiredValidation("$value is Required"));
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

  String? confirmPassValidation(String s, String passValue) {
    if (s.isEmpty || s == "") {
      emit(RequiredValidation("Confirm Password cannot be empty"));
    } else if (s != passValue) {
      emit(ConfirmPasswordState("Password doesn't match"));
    }
    emit(ValidState("valid"));
    return null;
  }
}

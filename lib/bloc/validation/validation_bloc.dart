import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';

class ValidationCubit extends Cubit<InitialValidation> {
  ValidationCubit() : super(InitialValidation());
  bool valid = false;
  bool pass = true;
  bool cPass = true;
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
      return "";
    } else if (!pattern.hasMatch(s)) {
      valid = false;
      emit(InvalidEmailState("Enter valid email"));
      return "";
    } else {
      // valid = true;
      // emit(ValidState("valid"));
      // return s;
    }

    return null;
  }

  String? requiredValidation(String s, value) {
    if (s.isEmpty || s == "") {
      print(">>>>>>>>>>  $s");
      emit(RequiredValidation("$value is required"));
      return "";
    } else {
      print(">>>>>>>>>> 1111 $s");
    }
    // emit(ValidState("valid"));
    return null;
  }
/*
  String? phoneValidation(String s) {
    if (s.isEmpty || s == "") {
      emit(RequiredValidation("Phone number is required"));
      return "";
    } else if (s.length < 10) {
      emit(InvalidPhoneState("Invalid Phone"));
      return "";
    }
    return null;
  }*/

  String? passwordValidation(String s) {
    if (s.isEmpty || s == "") {
      emit(RequiredValidation("Password cannot be empty"));
      return "";
    } else if (s.length < 6) {
      emit(InvalidPasswordState("Password must not be less then 6 digits"));
      return "";
    }
    // emit(ValidState("valid"));
    return null;
  }

  String? confirmPassValidation(String s, String passValue) {
    if (s.isEmpty || s == "") {
      emit(RequiredValidation("Confirm Password cannot be empty"));
      return "";
    } else if (s != passValue) {
      emit(ConfirmPasswordState("Password doesn't match"));
      return "";
    }
    // emit(ValidState("valid"));
    return null;
  }
}

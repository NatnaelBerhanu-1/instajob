import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/validation/validation_state.dart';

class ValidationCubit extends Cubit<InitialValidation> {
  ValidationCubit() : super(InitialValidation());
  bool emailVAL = false;
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

  emailCheck(val) {
    emailVAL = val;
    emit(InvalidEmailState(emailVAL));
  }
}

String? requiredValidationn(String s) {
  if (s.isEmpty || s == "") {
    return "*";
  }
  return null;
}

String? emailValidation(String s) {
  RegExp pattern = RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$');
  if (s.isEmpty) {
    print("!!!!!!!!");
    // showToast("Email cannot be empty");
    // emit(RequiredValidation("Email cannot be empty"));
    return "Email cannot be empty";
  }
  if (!pattern.hasMatch(s)) {
    // showToast("Enter valid email");
    // emit(InvalidEmailState("Enter valid email"));
    return "Enter valid email";
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
    // showToast("$value is required");

    // emit(RequiredValidation("$value is required"));
    return "$value is required";
  } else {
    print(">>>>>>>>>> 1111 $s");
  }
  // emit(ValidState("valid"));
  return null;
}

String? phoneValidation(String s) {
  if (s.isEmpty || s == "") {
    return "Phone number cannot be empty";
  } else {
    return "Enter valid phone number";
  }

  // return null;
}

String? passwordValidation(String s) {
  if (s.isEmpty || s == "") {
    // showToast("Password cannot be empty");
    // emit(RequiredValidation("Password cannot be empty"));
    return "Password cannot be empty";
  } else if (s.length < 6) {
    // showToast("Password must not be less then 6 digits");
    // emit(InvalidPasswordState("Password must not be less then 6 digits"));
    return "Password must not be less then 6 digits";
  }
  // emit(ValidState("valid"));
  return null;
}

String? confirmPassValidation(String s, String passValue) {
  if (s.isEmpty || s == "") {
    // showToast("Confirm Password cannot be empty");
    // emit(RequiredValidation("Confirm Password cannot be empty"));
    return "Confirm Password cannot be empty";
  } else if (s != passValue) {
    // showToast("Password doesn't match");
    // emit(ConfirmPasswordState("Password doesn't match"));
    return "Password doesn't match";
  }
  // emit(ValidState("valid"));
  return null;
}

String? hasValidUrl(String s, val) {
  String pattern = r'(?:https?:\/\/)?[\S+\.]\S+\.\S+';
  RegExp regExp = RegExp(pattern);
  if (s.isEmpty) {
    return '$val is required';
  } else if (!regExp.hasMatch(s)) {
    return 'Please enter valid url';
  }
  return null;
}

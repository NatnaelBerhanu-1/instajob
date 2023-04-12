import 'package:insta_job/globals.dart';

class AppValidation {
  static String? emailValidation(String s) {
    RegExp pattern = RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$');
    if (s.isEmpty) {
      // showToast("Email cannot be empty");
      // emit(RequiredValidation("Email cannot be empty"));
    } else if (!pattern.hasMatch(s)) {
      // showToast("Enter valid email");
      // emit(InvalidEmailState("Enter valid email"));
    }

    return null;
  }

  static String? requiredValidation(String s, value) {
    if (s.isEmpty || s == "") {
      // showToast("$value is Required");
      // emit(RequiredValidation("$value is Required"));
    }
    return null;
  }

  static String? passwordValidation(String s) {
    if (s.isEmpty || s == "") {
      // showToast("Password cannot be empty");
      // emit(RequiredValidation("Password cannot be empty"));
    } else if (s.length < 6) {
      showToast("Password must not be less then 6 digits");
      // emit(ValidState("Password must not be less then 6 digits"));
    }

    return null;
  }

  static String? confirmPassValidation(String s, String passValue) {
    if (s.isEmpty || s == "") {
      showToast("Confirm Password cannot be empty");
      // emit(RequiredValidation("Confirm Password cannot be empty"));
    } else if (s != passValue) {
      showToast("Password doesn't match");
      // emit(ConfirmPasswordState("Password doesn't match"));
    }
    // emit(ValidState("valid"));
    return null;
  }
}

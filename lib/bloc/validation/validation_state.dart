class InitialValidation {}

class InvalidEmailState extends InitialValidation {
  final bool email;

  InvalidEmailState(this.email);
}

class VisiblePassState extends InitialValidation {
  final bool visibleValue;

  VisiblePassState(this.visibleValue);
}

class ValidState extends InitialValidation {
  final String valid;

  ValidState(this.valid);
}

class InvalidPasswordState extends InitialValidation {
  final String pass;

  InvalidPasswordState(this.pass);
}

class RequiredValidation extends InitialValidation {
  final String require;

  RequiredValidation(this.require);
}

class PasswordReqValidation extends InitialValidation {
  final String require;

  PasswordReqValidation(this.require);
}

class ConfirmPasswordState extends InitialValidation {
  final String pass;

  ConfirmPasswordState(this.pass);
}

class InvalidPhoneState extends InitialValidation {
  final String phone;

  InvalidPhoneState(this.phone);
}

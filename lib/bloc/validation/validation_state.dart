class InitialValidation {}

class InvalidEmailState extends InitialValidation {
  final String email;

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

class ConfirmPasswordState extends InitialValidation {
  final String pass;

  ConfirmPasswordState(this.pass);
}

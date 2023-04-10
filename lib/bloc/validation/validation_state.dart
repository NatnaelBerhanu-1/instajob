class InitialValidation {}

class InvalidEmailState extends InitialValidation {
  final String email;

  InvalidEmailState(this.email);
}

class ValidState extends InitialValidation {
  final String valid;

  ValidState(this.valid);
}

class InvalidPasswordState extends InitialValidation {
  final String pass;

  InvalidPasswordState(this.pass);
}

class NameValidation extends InitialValidation {}

class RequiredValidation extends InitialValidation {
  final String require;

  RequiredValidation(this.require);
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_job/model/user_model.dart';

class AuthInitialState {}

class AuthState extends AuthInitialState {
  final UserModel userModel;

  AuthState({required this.userModel});
}

class AuthLoadingState extends AuthInitialState {
  // final bool isLoading;

  // AuthLoadingState({required this.isLoading});
}

class SuccessState extends AuthInitialState {
  // final bool isLoading;

  // AuthLoadingState({required this.isLoading});
}

class ErrorState extends AuthInitialState {
  final String error;

  ErrorState(this.error);
}

/// PHONE AUTH STATE
class VerificationCompletedState extends AuthInitialState {
  final PhoneAuthCredential? credential;

  VerificationCompletedState(this.credential);
}

class CodeSentState extends AuthInitialState {}

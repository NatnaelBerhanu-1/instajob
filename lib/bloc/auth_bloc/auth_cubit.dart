// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/auth_bloc/social_auth/social_auth.dart';
import 'package:insta_job/bloc/bottom_bloc/bottom_bloc.dart';
import 'package:insta_job/bloc/company_bloc/company_event.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/model/user_model.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/repository/auth_repository.dart';
import 'package:insta_job/screens/auth_screen/login_screen.dart';
import 'package:insta_job/screens/auth_screen/reg_more_information.dart';
import 'package:insta_job/screens/auth_screen/set_password.dart';
import 'package:insta_job/screens/auth_screen/verify_code_screen.dart';
import 'package:insta_job/screens/insta_recruit/became_an_employeer.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insta_job/screens/insta_recruit/membership_screen.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../company_bloc/company_bloc.dart';

class AuthCubit extends Cubit<AuthInitialState> {
  final SharedPreferences sharedPreferences;
  final AuthRepository authRepository;
  final CompanyBloc companyBloc;
  final BottomBloc user;

  AuthCubit(this.companyBloc, this.user, {required this.sharedPreferences, required this.authRepository})
      : super(AuthInitialState());
  String userName = "";
  String companyName = "";
  String email = "";
  String password = "";
  String website = "";
  String phoneNumber = "";
  String countryCode = "";
  String profilePic = "";
  String cv = "";
  String dob = "";
  bool isGUser = false;

  getData() {
    print("userName: $userName");
    print("email: $email");
    print("password: $password");
    print("phoneNumber: $phoneNumber");
    print("countryCode: $countryCode");
    print("profilePic: $profilePic");
    print("website: $website");
    print("cv: $cv");
  }

  registerData({bool isUser = false}) async {
    emit(AuthLoadingState());
    String type = sharedPreferences.getString("type").toString();
    ApiResponse response = await authRepository.registerData(
        name: userName,
        email: email,
        type: type,
        password: password,
        isUser: isUser,
        phoneNumber: phoneNumber,
        profilePic: profilePic,
        date: dob,
        companyName: companyName,
        cv: cv,
        websiteLink: website);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      // loading(value: true);
      await sharedPreferences.setString("user", jsonEncode(response.response.data['data']));
      var userModel = UserModel.fromJson(response.response.data['data']);
      Global.userModel = userModel;
      emit(AuthState(userModel: userModel));
      companyBloc.add(LoadCompanyListEvent());
      var agree = sharedPreferences.getBool('isAgree');
      if (agree == true) {
        navigationKey.currentState
            ?.pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const BottomNavScreen()), (route) => false);
      } else {
        navigationKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const MemberShipScreen(isAgreement: true)), (route) => false);
      }
    } else {
      emit(ErrorState("Something went wrong"));
    }
  }

  emitLoadingState() {
    emit (AuthLoadingState());
  }

  emitSuccessState() {
    emit (SuccessState());
  }

  emitErrorState([String errorMsg = "Error: Something happened! Try again"]) {
    emit (ErrorState(errorMsg));
  }

  login(
    BuildContext context, {
    String? email,
    String? password,
    bool isUser = false,
  }) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.loginData(email: email, password: password, isUser: isUser);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      await sharedPreferences.setString("user", jsonEncode(response.response.data['data']));
      var userModel = UserModel.fromJson(response.response.data['data']);
      Global.userModel = userModel;
      print('user ----------        ${userModel.id}  ');
      emit(AuthState(userModel: userModel));
      companyBloc.add(LoadCompanyListEvent());
      navigationKey.currentState
          ?.pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const BottomNavScreen()), (route) => false);
      context.read<GlobalCubit>().changeIndex(1);
    }
    if (response.response.statusCode == 400) {
      emit(ErrorState("${response.response.data['message']}"));
    }
  }

  /// =================== PHONE AUTH ================== ///
  String verificationCode = "";

  verifyPhone(BuildContext context, {bool isResend = false}) async {
    emit(AuthLoadingState());
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          _onVerificationCompletedRegister(credential, context);
          emit(VerificationCompletedState(credential));
        },
        verificationFailed: (FirebaseAuthException exception) {
          debugPrint("Error: ${exception.message}");
          debugPrintStack(stackTrace:exception.stackTrace);
          emit(ErrorState(exception.message.toString()));
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationCode = verificationId;
          if (!isResend) {
            emit(CodeSentState());
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationCode = verificationId;
        },
        timeout: const Duration(seconds: 60));
    // emit(AuthInitialState());
  }

  void _onVerificationCompletedRegister(PhoneAuthCredential phoneAuthCredential, BuildContext context) async {
    var type = sharedPreferences.getString("type");
    FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((value) async {
      if (value.user != null) {
        if (type == "user") {
          if (isSocialAuth) {
            registerData(isUser: true);
            context.read<GlobalCubit>().changeIndex(1);
          } else {
            SocialAuth.emailAndPass(context, isUser: true);
          }
        } else {
          if (isSocialAuth) {
            registerData();
          } else {
            SocialAuth.emailAndPass(context);
          }
        }
        // registerData(isUser: userType == "user" ? true : false);
      }
    }).catchError((e) {
      print("@@@@@@@@@ $e");
      if (e.code == "invalid-verification-code") {
        emit(ErrorState("Invalid OTP"));
      } else {
        emit(ErrorState(e.code.toString().replaceAll("-", " ")));
      }
    });
  }

  validateOTP(String code, BuildContext context) async {
    emit(AuthLoadingState());
    try {
      final PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verificationCode, smsCode: code);
      _onVerificationCompletedRegister(credential, context);
    } catch (e) {
      emit(ErrorState(e.toString()));
      showToast("Invalid OTP");
    }
  }

  resendCode() {}

  /// ======================================================== ///

  /// UPDATE USER
  updateUserData({
    String? name,
    String? phoneNumber,
    String? profilePhoto,
    String? dOB,
    String? resumeOrCv,
    String? fcmToken,
  }) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.updateUser(
      phoneNumber: phoneNumber,
      name: name,
      dOB: dOB,
      profilePhoto: profilePhoto,
      resumeOrCv: resumeOrCv,
      fcmToken: fcmToken,
    );
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      await sharedPreferences.setString("user", jsonEncode(response.response.data['data']));
      var userModel = UserModel.fromJson(response.response.data['data']);
      Global.userModel = userModel;
      debugPrint('ABEBE:${Global.userModel?.toJson()}');
      emit(AuthState(userModel: userModel));
      user.add(UserEvent());
    }
    if (response.response.statusCode == 400) {
      emit(ErrorState("${response.response.data['message']}"));
    }
  }

  /// EMPLOYEE UPDATE
  updateEmpData({
    String? name,
    // String? phoneNumber,
    String? profilePhoto,
    String? fcmToken,
    required bool fromTokenStore,
  }) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.updateEmp(
      // phoneNumber: phoneNumber,
      companyName: name,
      profilePhoto: profilePhoto,
      fcmToken: fcmToken,
    );
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      await sharedPreferences.setString("user", jsonEncode(response.response.data['data']));
      var userModel = UserModel.fromJson(response.response.data['data']);
      Global.userModel = userModel;
      emit(AuthState(userModel: userModel));
      if (fromTokenStore == false) {
        navigationKey.currentState?.pop();
        navigationKey.currentState?.pop();
      }
      user.add(UserEvent());
    }
    if (response.response.statusCode == 400) {
      emit(ErrorState("${response.response.data['message']}"));
    } else {
      emit(ErrorState("Something happened"));
    }
  }

  /// google auth
  bool isSocialAuth = false;
  googleAuth(BuildContext context) async {
    loading(value: true);
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    final googleUser = await googleSignIn.signIn();
    var type = sharedPreferences.getString("type");
    try {
      loading(value: false);
      isSocialAuth = true;
      emit(AuthInitialState());
      final googleAuth = await googleUser?.authentication;
      debugPrint("GoogleAuth: $googleAuth");
      if(googleAuth == null) {
        emit(ErrorState("Cancelled by user"));
        return;
      }
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
        if (value.user != null) {
          ApiResponse response = await authRepository.checkUser(value.user!.email.toString());
          if (response.response.statusCode == 200) {
            login(
              context,
              email: value.user!.email,
              isUser: type == "user" ? true : false,
              password: "123456",
            );
            // navigationKey.currentState?.pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (_) => const BottomNavScreen()),
            //     (route) => false);
          } else {
            userName = value.user!.displayName!;
            email = value.user!.email!;
            password = "123456";
            getData();
            print("_++++++++++++++++++++++ $type");
            if (type == "user") {
              navigationKey.currentState?.push(
                MaterialPageRoute(builder: (_) => const RegMoreInfoScreen()),
              );
            } else {
              navigationKey.currentState?.push(MaterialPageRoute(builder: (_) => const BecameAnEmployer()));
            }
          }
          // registerEmp(
          // email: value.user!.email,
          // isUser: isUser,
          // password: value.user!.uid,
          // name: value.user!.displayName,
          // );
          // var userModel = UserModel.fromJson(response.response.data['data']);
          // Global.userModel = userModel;
          // await sharedPreferences.setString(
          //     "user", jsonEncode(response.response.data['data']));
          // emit(AuthState(userModel: userModel));

          print('USERRRR ------------------           ${value.user}');
        }
      });
    } catch (e, stk) {
      debugPrint("Error:${e.toString()}");
      debugPrintStack(stackTrace: stk);
      loading(value: false);
      emit(ErrorState("Something went wrong"));
    }
  }

  /// CHECK USER
  Future<bool> checkUser(String email, BuildContext context) async {
    debugPrint("State: ${state}");
    emit(AuthLoadingState());
    debugPrint("State: ${state}");
    ApiResponse response = await authRepository.checkUser(email);
    if (response.response.statusCode == 200) {
      emit(AuthInitialState());
      return true;
    } else {
      emit(AuthInitialState());
      return false;
    }
  }

  /// facebook
  faceBookAuth(BuildContext context,{bool isUser = false}) async {

    try {
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);
      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final OAuthCredential facebookCredential = FacebookAuthProvider.credential(accessToken.token);
        FirebaseAuth.instance.signInWithCredential(facebookCredential).then((value) async {
          print('THENN ');
          if (value.user != null) {
            if(value.user?.email == null) {
              showToast("No email address associated with this apple id, email address is required to create an account.", durationInSeconds: 5);
                  loading(value: false);
              return;
            }
            ApiResponse response = await authRepository.checkUser(value.user!.email.toString());
            debugPrint('ResponseCode: ${response.response.statusCode}');
            if (response.response.statusCode == 200) {
              login(
                context,
                  email: value.user!.email,
                  isUser: isUser,
                  password: value.user!.uid);
              navigationKey.currentState?.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const BottomNavScreen()),
                  (route) => false);
            } else {
              userName = value.user?.displayName ?? "";
              email = value.user?.email ?? "";
              password = value.user?.uid ?? "";
              getData();
              navigationKey.currentState?.push(
                MaterialPageRoute(builder: (_) => isUser ? const RegMoreInfoScreen() : const BecameAnEmployer()),
              );
            }
            // registerEmp(
            // email: value.user!.email,
            // isUser: isUser,
            // password: value.user!.uid,
            // name: value.user!.displayName,
            // );
            // var userModel = UserModel.fromJson(response.response.data['data']);
            // Global.userModel = userModel;
            // await sharedPreferences.setString(
            //     "user", jsonEncode(response.response.data['data']));
            // emit(AuthState(userModel: userModel));

            print('USERRRR ------------------           ${value.user}');
          }
        });
      } else {
        print('TOKENN ----------          ');
      }
    } catch (e) {
      print('EEEEEEEEEEEEEEEEEEEEE ${e.toString()}');

      emit(ErrorState(e.toString()));
    }
  }

  appleAuth(BuildContext context) async {
    loading(value: true);

    final appleProvider = AppleAuthProvider();
    appleProvider.addScope('email');
    appleProvider.addScope('name');
    var type = sharedPreferences.getString("type");

    try {
      final credential = await FirebaseAuth.instance.signInWithProvider(appleProvider);
      var email = credential.user!.email;
      debugPrint('Email: ${credential.user!.email.toString()}');
      if(email == null) {
        showToast("No email address associated with this apple id, email address is required to create an account.", durationInSeconds: 5);
            loading(value: false);
        return;
      }
      ApiResponse response = await authRepository.checkUser(credential.user!.email.toString());

      if (response.response.statusCode == 200) {
            login(
              context,
              email: credential.user!.email,
              isUser: type == "user" ? true : false,
              password: "123456",
            );
            // navigationKey.currentState?.pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (_) => const BottomNavScreen()),
            //     (route) => false);
          } else {
            userName = credential.user?.displayName ?? "";
            email = credential.user?.email ?? "";
            password = "123456";
            getData();
    loading(value: false);
            
            if (type == "user") {
              navigationKey.currentState?.push(
                MaterialPageRoute(builder: (_) => const RegMoreInfoScreen()),
              );
            } else {
              navigationKey.currentState?.push(MaterialPageRoute(builder: (_) => const BecameAnEmployer()));
            }
          }
    } catch (e, stk) {
    loading(value: false);
      debugPrint("Error: $e");
      debugPrintStack(stackTrace: stk);
    }
    
  }

  ///logout
  logOut() async {
    try {
      emit(AuthLoadingState());
    //TODO: wrap calls in try catch
    ApiResponse response = await authRepository.logOutUser();
    GoogleSignIn googleSignIn = GoogleSignIn();

    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      await sharedPreferences.remove("user");

      if (isSocialAuth) {
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
        await FirebaseAuth.instance.signOut();
      } else {
        await FirebaseAuth.instance.signOut();
      }
      user.add(ResetIndex());
      emit(SuccessState());
      navigationKey.currentState
          ?.pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const UserTypeScreen()), (route) => false);
    } else {
      emit(ErrorState("Something went wrong"));
    }
    } catch (e) {
      emit(ErrorState("Something went wrong"));
    }
  }

  /// SEND CODE
  sendCodeOnEmail({required String email}) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.sendCodeOnEmail(email: email);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      emit(SuccessState());
      showToast("Send code on your email", color: MyColors.black);
      navigationKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => const VerifyCodeScreen(isForgotPassword: true)));
    }
    if (response.response.statusCode == 400) {
      emit(ErrorState("Email not register yet"));
    }
  }

  checkEmailVerificationCode({required String email, required String code}) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.checkEmailVerificationCode(email: email, code: code);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      // if (response.response.data["statusCode"] == 200) {
      emit(SuccessState());
      navigationKey.currentState?.pushReplacement(MaterialPageRoute(builder: (_) => const SetPassword()));
      // } else {
      //   emit(ErrorState("error"));
      // }
    }
    if (response.response.statusCode == 400) {
      //todo: add else condition or make it else, after checking the status code is in 200s in the prev condition //done
      // showToast("Code not match");
      emit(ErrorState("Code Not Match"));
    } else {
      emit(ErrorState("Something happened please try again later")); //revisit msg
    }
  }

  /// CHECK PHONE NUMBER
  checkPhoneNumber(BuildContext context) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.checkPhoneNumber(phoneNumber);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      emit(ErrorState("Phone number already exist"));
      emit(SuccessState());
    }
    if (response.response.statusCode == 400) {
      if (response.response.data["success"] == 400) {
        debugPrint("Verifying Phone Number");
        await verifyPhone(context);
      } else {
        emit(ErrorState("Something went wrong"));
      }
    }
  }

  Future<void> signInWithTwitter({bool isUser = false}) async {
    TwitterAuthProvider twitterProvider = TwitterAuthProvider();

    final value = await FirebaseAuth.instance.signInWithProvider(twitterProvider);
    if (value.user != null) {
      ApiResponse response = await authRepository.checkUser(value.user!.email.toString());
      if (response.response.statusCode == 200) {
        // login(
        //     email: value.user!.email,
        //     isUser: isUser,
        //     password: value.user!.uid);
        // navigationKey.currentState?.pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (_) => const BottomNavScreen()),
        //     (route) => false);
      } else {
        userName = value.user!.displayName!;
        email = value.user!.email!;
        password = value.user!.uid;
        getData();
        navigationKey.currentState?.push(
          MaterialPageRoute(builder: (_) => isUser ? const RegMoreInfoScreen() : const BecameAnEmployer()),
        );
      }
      // registerEmp(
      // email: value.user!.email,
      // isUser: isUser,
      // password: value.user!.uid,
      // name: value.user!.displayName,
      // );
      // var userModel = UserModel.fromJson(response.response.data['data']);
      // Global.userModel = userModel;
      // await sharedPreferences.setString(
      //     "user", jsonEncode(response.response.data['data']));
      // emit(AuthState(userModel: userModel));

      print('USERRRR ------------------           ${value.user}');
    }
  }

/*  /// RESEND CODE

  reSendCodeForEmp({required String email}) async {
    // emit(AuthLoadingState());
    ApiResponse response = await authRepository.resendCodeForEmp(email: email);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      emit(SuccessState());
    }
    if (response.response.statusCode == 400) {
      emit(ErrorState("${response.response.data['message']}"));
    }
  }

  reSendCodeForUser({required String email}) async {
    // emit(AuthLoadingState());
    ApiResponse response = await authRepository.resendCodeForUser(email: email);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      emit(SuccessState());
    }
    if (response.response.statusCode == 400) {
      emit(ErrorState("${response.response.data['message']}"));
    }
  }*/

  changePassword({required String password, required String email}) async {
    emit(AuthLoadingState());
    ApiResponse response = await authRepository.changePassword(password: password, email: email);
    if (response.response.statusCode == 500) {
      emit(ErrorState("Something went wrong"));
    }
    if (response.response.statusCode == 200) {
      emit(SuccessState());
      showToast("Password change successfully", isError: false);
      navigationKey.currentState?.pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
    if (response.response.statusCode == 400) {
      emit(ErrorState("${response.response.data['message']}"));
    }
  }

  /// UPDATE USER TOKEN
  updateUserTokenData({
    String? name,
    String? phoneNumber,
    String? profilePhoto,
    String? dOB,
    String? resumeOrCv,
    String? fcmToken,
  }) async {
    ApiResponse response = await authRepository.updateUser(
      phoneNumber: phoneNumber,
      name: name,
      dOB: dOB,
      profilePhoto: profilePhoto,
      resumeOrCv: resumeOrCv,
      fcmToken: fcmToken,
    );
  }

  /// EMPLOYEE TOKEN UPDATE
  updateEmpTokenData({
    String? name,
    // String? phoneNumber,
    String? profilePhoto,
    String? fcmToken,
  }) async {
    ApiResponse response = await authRepository.updateEmp(
      // phoneNumber: phoneNumber,
      companyName: name,
      profilePhoto: profilePhoto,
      fcmToken: fcmToken,
    );
  }

Future<ApiResponse> deleteAccount(
    String user_id,
    String userType
  ) async {
ApiResponse response = await authRepository.deleteAccount(
      // phoneNumber: phoneNumber,
      user_id: user_id,
      userType: userType,
    );
    return response;
  }
}

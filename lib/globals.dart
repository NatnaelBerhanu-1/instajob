import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:insta_job/utils/my_colors.dart';

import 'model/user_model.dart';

class Global {
  // static String? type;
  static UserModel? userModel;
}

BoxShadow boxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.10),
  offset: const Offset(3, 3),
  spreadRadius: 5,
  blurRadius: 7,
);

BoxShadow blueBoxShadow = BoxShadow(
  color: MyColors.lightBlue.withOpacity(0.10),
  offset: const Offset(0, 5),
  spreadRadius: 5,
  blurRadius: 10,
);
BoxShadow normalBoxShadow = BoxShadow(
  color: Colors.red.withOpacity(0.25),
  offset: const Offset(0, 4),
  spreadRadius: 2,
  blurRadius: 7,
);

showToast(message, {color, textColor, bool isError = false}) {
  EasyLoading.instance
    ..toastPosition = EasyLoadingToastPosition.top
    ..textColor = textColor ?? MyColors.white
    ..backgroundColor = isError ? MyColors.lightRed : color;
  EasyLoading.showToast(message);
}

dynamic loading(
    {@required bool? value, String? title, bool closeOverlays = false}) {
  if (value!) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..backgroundColor = MyColors.black
      ..maskColor = MyColors.grey.withOpacity(.2)

      /// custom style
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = MyColors.blue
      ..textColor = MyColors.white

      ///
      ..userInteractions = false
      ..animationStyle = EasyLoadingAnimationStyle.offset;
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      status: "Loading..",
      dismissOnTap: true,
    );
  } else {
    EasyLoading.dismiss();
  }
}

final navigationKey = GlobalKey<NavigatorState>();

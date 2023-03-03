import 'package:flutter/material.dart';

class AppRoutes {
  static push(BuildContext context, Widget name) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => name));
  }

  static pop(
    BuildContext context,
  ) {
    return Navigator.pop(context);
  }

  static pushAndRemoveUntil(BuildContext context, Widget name) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => name),
      (route) => false,
    );
  }

  static pushReplacement(BuildContext context, Widget name) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => name));
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}

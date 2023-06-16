// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:insta_job/bloc/bloc_providers.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/screens/insta_recruit/splash_screen.dart';

import 'di_container.dart' as di;
import 'utils/my_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  // await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.white,
          fontFamily: "Inter",
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        home: SplashScreen(),
        navigatorKey: navigationKey,
        builder: EasyLoading.init(),
      ),
    );
  }
}

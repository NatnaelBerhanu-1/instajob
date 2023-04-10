// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:insta_job/bloc/bloc_providers.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/provider/providers.dart';
import 'package:insta_job/screens/insta_recruit/splash_screen.dart';
import 'package:provider/provider.dart';
import 'utils/my_colors.dart';
import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: MyColors.white,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
          ),
          home: SplashScreen(),
          navigatorKey: navigationKey,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

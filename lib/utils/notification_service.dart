import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final StreamController<String?> selectNotificationStream =
  StreamController<String?>.broadcast();
  final Logger _logger = Logger();

  /// A notification action which triggers a url launch event
  String urlLaunchActionId = 'id_1';

  /// A notification action which triggers a App navigation event
  String navigationActionId = 'id_3';

  static bool _notificationsEnabled = false;

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // ignore: avoid_print
    print('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }

  // Initialize the service
  Future<void> init({required BuildContext context}) async {
    _isAndroidPermissionGranted();
    _requestPermissions(context);

    // Android notification channel setup
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('logo');
    // AndroidInitializationSettings('text_logo2');

    const InitializationSettings initializationSettings =
     InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _displayNotification(message);
    });

    // App opened from background by tapping on a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _logger.i('A new onMessageOpenedApp event was published!');
      // Handle the tap
      // Here, you can navigate to a specific screen or execute other actions
    });

    // Fetch the initial message if the app is opened directly by tapping the notification
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _logger.i('App opened via notification!');
      // Navigate or perform action if necessary
    }

    _firebaseMessaging.getToken().then((token) {
      // You can store this token in Firestore for each user
      _logger.i("FCM Token from get token: $token");
      var userModel = Global.userModel;
      if (userModel != null) {
        updateCurrentUserToken(context, token);
      }

    });

    _firebaseMessaging.onTokenRefresh.listen((token) {
      // Update the token in Firestore
      _logger.i("Refreshed FCM Token: $token");
      
    });

    _handleInitialMessage();
  }

  void updateCurrentUserToken(BuildContext context, String? token) {
    debugPrint("LOGGGG: Name: ${Global.userModel?.name}, email: ${Global.userModel?.email}, dob: ${Global.userModel?.date}, phone: ${Global.userModel?.phoneNumber}, cv: ${Global.userModel?.cv}, photo: ${Global.userModel?.uploadPhoto}");
    var name = Global.userModel?.name;
    var email = Global.userModel?.email;
    var dob = Global.userModel?.date;
    var phone = Global.userModel?.phoneNumber;
    var cv = Global.userModel?.cv;
    var photo = Global.userModel?.uploadPhoto;
    
    
    var authData = context.read<AuthCubit>();
    
    if (Global.userModel?.type == "user") {
      authData.updateUserTokenData(
        profilePhoto: photo,
        dOB: dob,
        name: name,
        phoneNumber: phone,
        resumeOrCv: cv,
        fcmToken: token,
      );
      // authData.updateUserData(
      //   profilePhoto: photo,
      //   dOB: dob,
      //   name: name,
      //   phoneNumber: phone,
      //   resumeOrCv: cv,
      //   fcmToken: token,
      // );
    } else {
      authData.updateEmpTokenData(
        profilePhoto: photo,
        name: name,
        fcmToken: token,
      );
      // authData.updateEmpData(
      //   profilePhoto: photo,
      //   name: name,
      //   fcmToken: token,
      //   fromTokenStore: true
      // );
    }
  }

  // Helper method to display a notification
  void _displayNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _logger.i("############## is notification coming title :: ${message.notification!.title}");
      _logger.i("############## is notification coming body :: ${message.notification!.body}");
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_ID',
            'channel_Name',
            channelDescription:'channel_Description',
            // icon: 'your_icon_here',    // Optional. Specify the name of the notification icon.
            importance: Importance.max,  // Optional. You can specify importance, priority, etc.
            priority: Priority.high,     // Optional.
          ),
        ),
      );
    }else{
      _logger.i("############## is notification coming it seems the incoming data is null");
    }
  }

  Future<void> _handleInitialMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _logger.i('The app was opened from a terminated state by tapping on a notification!');
      // Handle the tap
    }
  }



  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      _notificationsEnabled = granted;

    }
  }

  Future<void> _requestPermissions(BuildContext context) async {
    if (Platform.isIOS) {
      var sharedPrefs = await SharedPreferences.getInstance();
      debugPrint("NotificationPermission: ${sharedPrefs.getBool('notification_denied')}");
      if(sharedPrefs.getBool('notification_denied') != true) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        buildDialog(context, CustomDialog(
          headerImagePath: MyImages.cancel,
          confirmBtnLabel: "Continue",
          popAfterOnTap: true,
          title: "Notification permission",
          desc1: Global.userModel?.type == "user" ? "Enable notification permission in to recieve notifications about status of your job applications." : "Enable notification permission in to recieve notifications about status of your job postings.",
          cancelOnTap: () async{
            await sharedPrefs.setBool("notification_denied", true);
          },
          okOnTap: () async {
                var status = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
          if(status != true) {
            await sharedPrefs.setBool("notification_denied", true);
            showToast('Notification permissions denied. please enable in settings');
          }
        },
      ));
      });
      }
      
      
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      _notificationsEnabled = granted ?? false;

    }
  }

}

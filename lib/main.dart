import 'dart:async';
import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:serenestream/auth/screens/first_screen.dart';
import 'package:serenestream/auth/screens/otp_screen.dart';
import 'package:serenestream/auth/screens/register_screen.dart';
import 'package:serenestream/auth/screens/reset_password.dart';
import 'package:serenestream/chart_screens/stress_chart_screen.dart';
import 'package:serenestream/chat/chat_screen.dart';
import 'package:serenestream/home/dashboard_screen.dart';
import 'package:serenestream/home/select_music_screen.dart';
import 'package:serenestream/meditation/set_duration_screen.dart';
import 'package:serenestream/meditation/timer_screen.dart';
import 'package:serenestream/intro/select_expression.dart';
import 'package:serenestream/intro/select_feelings.dart';
import 'package:serenestream/intro/select_gender_screen.dart';
import 'package:serenestream/intro/select_sleep_hours.dart';
import 'package:serenestream/questions/test_mood_screen.dart';
import 'package:serenestream/screens/radial_gauge_screen.dart';
import 'package:serenestream/splash/splash_screen.dart';
import 'package:serenestream/utils/logx.dart';
import 'package:serenestream/utils/storage_service.dart';
import 'package:serenestream/utils/storage_service_apple.dart';

import 'Constants/app_theme.dart';
import 'Constants/colors.dart';
import 'auth/util/firebase_options.dart';
import 'home/home_screen.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  // await setPreferredOrientations();
  //await ScreenUtil.ensureScreenSize();
  await StorageService.init();
  await StorageServiceApple.init();

  // await setBaseUrl();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
/*  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  await requestForPermission();*/

  await Firebase.initializeApp(
      name: "scerenestream", options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SerenestreamApplication());
}
/*late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;*/

/*Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  // await setPreferredOrientations();
  //await ScreenUtil.ensureScreenSize();
  await StorageService.init();

  // await setBaseUrl();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
*//*  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  await requestForPermission();*//*

  await Firebase.initializeApp(
      name: "scerenestream", options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SerenestreamApplication());
}*/


/*
requestForPermission() async {

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    final bool? grantedNotificationPermission =
    await androidImplementation?.requestNotificationsPermission();

    LogX.printError(
        'User Notification Android granted permission: $grantedNotificationPermission');

}
*/

/*Future<void> setBaseUrl() async {
  String baseUrl = await AppConfig.getBaseUrl();
  NetworkClient.baseUrl = baseUrl;
}*/

/*Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}*/

class SerenestreamApplication extends StatefulWidget {
  const SerenestreamApplication({super.key});

  @override
  State<SerenestreamApplication> createState() => _SerenestreamApplicationState();


}

class _SerenestreamApplicationState extends State<SerenestreamApplication> {
  // It is assumed that all messages contain a data field with the key 'type'
  /*Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
 *//*   RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();*//*

  }*/



  @override
  void initState() {
    super.initState();

  //  setupInteractedMessage();

   // FirebaseMessaging.onMessage.listen(showFlutterNotification);
    // FirebaseMessaging.onMessageOpenedApp.listen(showFlutterNotification);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GetMaterialApp(
      title: "Serenestream",
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme(),),
    );
  }
}


/*
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  */
/*await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );*//*

  isFlutterLocalNotificationsInitialized = true;
}
*/

/*
void showFlutterNotification(RemoteMessage message) async {


  LogX.printError("KEYBOARD Today ${message.data}");
  LogX.printError("KEYBOARD Today ${message.data['body']}");


  String finalFormatted = "";


  LogX.printWaring(finalFormatted);


  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          color: AppColors.appColor,
          channelDescription: channel.description,
          styleInformation: BigTextStyleInformation('${notification.body}'),
          icon: "",
        ),
      ),
    );
  }
}
*/




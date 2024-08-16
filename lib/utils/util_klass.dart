import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:serenestream/home/dashboard_screen.dart';
import 'package:serenestream/utils/storage_service.dart';
import 'package:serenestream/utils/storage_service.dart';

import 'AppCommonFeatures.dart';


class UtilKlass {
  ValueChanged<String>? onDateSelected;

  static void navigateScreen(Widget widget) {
    Get.to(widget,
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 500));
  }

  static void navigateScreenTop(Widget widget) {
    Get.to(widget,
        transition: Transition.downToUp,
        duration: const Duration(milliseconds: 500));
  }

  static Color getBorderColor(BuildContext context) {
    return UtilKlass.isLightMode(context)
        ? const Color(0xFFD1D5D8)
        : const Color(0xFFD1D5D8);
  }

  static void navigateScreenArguments(Widget widget, dynamic args) {
    Get.to(widget, transition: Transition.cupertino, arguments: args);
  }

  static void navigateScreenOff(Widget widget) {
    Get.off(widget,
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 500));
  }

  static void navigateScreenOffAll(Widget widget) {
    Get.offAll(widget, transition: Transition.fade);
  }

  static bool checkIsAndroid() {
    var isAndroid = GetPlatform.isAndroid;

    return isAndroid;
  }

  static Widget getCardTypeView(BuildContext context, Widget widget) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.w),
      ),
      color: UtilKlass.isLightMode(context)
          ? Colors.white
          : Theme.of(context).colorScheme.background,
      elevation: 2.w,
      surfaceTintColor: Colors.white,
      child: widget,
    );
  }

  static Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  static Future<bool> showInternetConnectionMessage(
      BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      if (context.mounted) {
        showToastMsg(context, "No Internet Connection");
      }
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  static void showProgressAppLoading(BuildContext context) {
    Loader.show(context,
        isAppbarOverlay: true,
        isBottomBarOverlay: true,
        isSafeAreaOverlay: true,
        progressIndicator: const CircularProgressIndicator(
            backgroundColor: Colors.black),
        themeData: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: Colors.black)));
  }

  static void hideProgressAppLoading() {
    Loader.hide();
  }

  static bool checkIsIOS() {
    var isIOS = GetPlatform.isIOS;
    return isIOS;
  }

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }

  static void showToastMsg(BuildContext context, String dynamic) {
    showToast(dynamic,
        context: context,
        animation: StyledToastAnimation.fadeScale,
        reverseAnimation: StyledToastAnimation.slideToBottom,
        position: StyledToastPosition.bottom,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(10.0),
        curve: Curves.elasticOut,
        textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
        // fontFamily: Konstant.MEDIUM - can add font family
        backgroundColor: Colors.black87,
        reverseCurve: Curves.linear);
  }


  static void showBarMsg(String dynamic) {
    Get.snackbar("", dynamic);

    // Can change UI & features
  }

  static String getString(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return "";
    } else {
      return controller.text.toString().trim();
    }
  }

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Color randomColor() {
    return Color(Random().nextInt(0xffffffff));
  }

  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  static showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          height: 90,
          width: 90,
          child: Text("Please wait"),
        );
      },
    );
  }

  static hideProgressDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    UtilKlass.showToastMsg(context, "Google12");
    FirebaseAuth auth = FirebaseAuth.instance;
    UtilKlass.showToastMsg(context, "Google13");
    User? user;
    UtilKlass.showToastMsg(context, "Google14");
    final GoogleSignIn googleSignIn = GoogleSignIn();
    UtilKlass.showToastMsg(context, "Google15");

    try {
      UtilKlass.showToastMsg(context, "Google5");

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      UtilKlass.hideProgressAppLoading();

      if (googleSignInAccount != null) {
        UtilKlass.showToastMsg(context, "Google6");

        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential = await auth.signInWithCredential(credential);
        user = userCredential.user;
        print("Google Sign-In successful: ${user?.uid}");
      }else{
        UtilKlass.showToastMsg(context, "Google7");

      }
    } on FirebaseAuthException catch (e) {
      UtilKlass.showToastMsg(context, "Google8");

      print("FirebaseAuthException: ${e.code}");
      if (e.code == 'account-exists-with-different-credential') {
        UtilKlass.showToastMsg(context, "Google9");

        // handle the error here
      } else if (e.code == 'invalid-credential') {
        UtilKlass.showToastMsg(context, "Google10");

        // handle the error here
      }
    } catch (e) {
      UtilKlass.showToastMsg(context, "Google11");

      print("Exception: $e");
      // handle the error here
    }

    return user;
  }
/*
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    UtilKlass.hideProgressAppLoading();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }
*/
  static void addDataInFirestore(var user,Widget widget){

    FirebaseFirestore.instance
        .collection('users').doc(user["email"]).set(user)
        .then((value) => {
      UtilKlass.hideProgressAppLoading(),
      StorageService.saveData(StorageKeys.isLogin.toString(), true),

      StorageService.saveData(StorageKeys.emailId.toString(), user["email"]),
      UtilKlass.saveUserData(),
      UtilKlass.navigateScreenOffAll(widget)

    });

 /*   add(user).then((DocumentReference doc) =>{
      UtilKlass.hideProgressAppLoading(),
      StorageService.saveData(StorageKeys.isLogin.toString(), true),
      StorageService.saveData(StorageKeys.emailId.toString(), user["email"]),
      UtilKlass.navigateScreenOffAll(widget)
    });*/

  }
  static Future<void> addMoodDataInFirestore(var mood,var moodId,var emailId,BuildContext context) async {

      var usersRef =await FirebaseFirestore.instance.collection('UserMood').doc("${moodId.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}");

      usersRef.get()
          .then((docSnapshot) => {
      if (docSnapshot.exists) {
        FirebaseFirestore.instance
            .collection('UserMood').doc("${moodId.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}").update(mood).then((value) => {
              UtilKlass.hideProgressAppLoading(),
          UtilKlass.showToastMsg(context, "Mood Updated Successfully")
            }),

    } else {
        FirebaseFirestore.instance
            .collection('UserMood').doc("${moodId.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}").
        set(mood).then((value) => {
          UtilKlass.hideProgressAppLoading(),
          UtilKlass.showToastMsg(context, "Mood Updated Successfully"),

        }),
    }
    });



  }
  static Future<void> addUserSessionDataInFirestore(Map<String,dynamic> stats,var statsId,var emailId) async {

    var usersRef =await FirebaseFirestore.instance.collection('UserSession').doc("${statsId.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}");

    usersRef.get()
        .then((docSnapshot) => {
      if (docSnapshot.exists) {
        stats['session']=stats['session']+1,
        FirebaseFirestore.instance
            .collection('UserSession').doc("${statsId.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}").update(stats).then((value) =>  UtilKlass.hideProgressAppLoading()),


      }else{
        FirebaseFirestore.instance
            .collection('UserSession').doc("${statsId.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}").
        set(stats).then((value) => UtilKlass.hideProgressAppLoading(),),

      }
    });

  }


  static Future<void> addUserStatsDataInFirestore(var stats,var statsId,var email) async {
   /* FirebaseFirestore.instance.collection('UserStats').get().then(
          (querySnapshot) {
           var docSnapshot=querySnapshot.docs.last;
           DateTime from=
           DateTime to=

           var from = DateTime(from.year, from.month, from.day);
           var to = DateTime(to.year, to.month, to.day);
           int days= (to.difference(from).inHours / 24).round();

          },
      onError: (e) => print("Error completing: $e"),
    );*/

    var usersRef =await FirebaseFirestore.instance.collection('UserStats').doc("${statsId.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}");

    usersRef.get()
        .then((docSnapshot) => {
      if (docSnapshot.exists) {
        FirebaseFirestore.instance
            .collection('UserStats').doc("${statsId.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}").update(stats).then((value) =>  UtilKlass.hideProgressAppLoading()),

      } else {
        FirebaseFirestore.instance
            .collection('UserStats').doc("${statsId.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}").
        set(stats).then((value) => UtilKlass.hideProgressAppLoading(),),
      }
    });



  }

  static DateTime getCurrentDate(){
    DateTime nowWithTime = DateTime.now();
    DateTime now = DateTime(nowWithTime.year, nowWithTime.month, nowWithTime.day);
    return now;

  }
  static Future<bool> otpExists(String email,String otp_value,int date_s) async {
    return (
        await FirebaseFirestore.instance
        .collection('otp')
        .doc('${otp_value}')
        .get())
        .exists;
  }
  static Future<bool> otpValid(String email,String otp_value,int date_s) async {
    final data =  await FirebaseFirestore.instance
        .collection('otp')
        .doc('${otp_value}')
        .get(); //get the data
    DocumentSnapshot snapshot=data; //Define snapshot

    return snapshot['email'].toString()==email;
  }
  static Future<bool> otpNotExpire(String email,String otp_value,int date_s) async {
/*
    debugPrint("***expirer@*******1*************${date_s}**********");
    int duration=DateTime.now().millisecondsSinceEpoch;

    debugPrint("***expirer@*******2*************${duration}**********");
    duration=duration-date_s;
    debugPrint("***expirer@*******3*************${duration}**********");*/

    debugPrint("***datetime@*******1*************${DateTime.now()}**********");
    var dt = DateTime.fromMillisecondsSinceEpoch(date_s);
    debugPrint("***datetime@*******2*************$dt");
    var diff=DateTime.now().difference(dt);
    debugPrint("***datetime@*******3*************${diff.inMinutes}");

    return diff.inMinutes<=10;
  }


  static Future<String> giveWeekDayMood(DateTime date_s)  async {
    debugPrint("**********dekhooooo*************${date_s.toString()}**********");

    try {
      final data = await FirebaseFirestore.instance
          .collection('UserMood')
          .doc("${date_s.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}")
          .get(); //get the data
      DocumentSnapshot snapshot = data; //Define snapshot
      var mood_str = snapshot.get('mood');

      var retuenvalue = "";

      switch (mood_str) {
        case "Happy":
          retuenvalue = AppCommonFeatures.instance.imagesFactory.happy_comp;
          break;
        case "Sad":
          retuenvalue = AppCommonFeatures.instance.imagesFactory.sad_comp;
          break;
        case "Mad":
          retuenvalue = AppCommonFeatures.instance.imagesFactory.mad_comp;
          break;
        case "Normal":
          retuenvalue = AppCommonFeatures.instance.imagesFactory.normal_comp;
          break;
        default:
          retuenvalue = "LPTOP";
      }

      return retuenvalue;
    }
    catch(Exception){
      return Future.value(AppCommonFeatures.instance.imagesFactory.normal_comp);
    }
  }
  static Future<int> giveStreakData(DateTime date_s) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('UserStats').doc("${date_s.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}").get();
      // Assuming 'streak' is of type int in the Firestore document
      return documentSnapshot.get('streak') as int;
    } catch (e) {
      print('Error fetching streak data: $e');
      return 0; // Return 0 as default value if there's an error
    }
  }
  static Future<int> giveSessionData(DateTime date_s) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('UserSession').doc("${date_s.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}").get();
      // Assuming 'streak' is of type int in the Firestore document
      return documentSnapshot.get('session') as int;
    } catch (e) {
      print('Error fetching session data: $e');
      return 0; // Return 0 as default value if there's an error
    }
  }

  static int generateOTPNumber() {
    final Random _random =
    Random(); // Create a Random object for generating random numbers
    int _randomNumber = 0;
    _randomNumber =
        100000 + _random.nextInt(900000);
    debugPrint("randomNUMBER**********$_randomNumber");
   return _randomNumber;// Generates a random 6-digit number

  }

  static DateTime getCurrentWeekStart() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    DateTime monday = now.subtract(Duration(days: currentWeekday - 1));
    return DateTime(monday.year, monday.month, monday.day);  // start of the day
  }

  static DateTime getCurrentWeekEnd() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    DateTime sunday = now.add(Duration(days: 7 - currentWeekday));
    return DateTime(sunday.year, sunday.month, sunday.day, 23, 59, 59);  // end of the day
  }

  static Future<List<Map<String, dynamic>>> fetchCurrentWeekData() async {
    DateTime startOfWeek = getCurrentWeekStart();
    DateTime endOfWeek = getCurrentWeekEnd();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('weeklymood')
          .where('date', isGreaterThanOrEqualTo: startOfWeek.toIso8601String().split('T').first)
          .where('date', isLessThanOrEqualTo: endOfWeek.toIso8601String().split('T').first)
          .orderBy('date')
          .get();

      List<Map<String, dynamic>> moods = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return moods;
    } catch (e) {
      print('Error fetching weekly mood data: $e');
      return [];
    }
  }

  static List<DateTime> getCurrentWeekDates() {
    DateTime start = getCurrentWeekStart();
    return List.generate(7, (index) => start.add(Duration(days: index)));
  }

  static List<Map<String, dynamic>> mergeWithDefaultData(List<Map<String, dynamic>> firestoreData) {
    List<DateTime> weekDates = getCurrentWeekDates();
    Map<String, Map<String, dynamic>> dataMap = {
      for (var item in firestoreData) item['date']: item
    };
    List<Map<String, dynamic>> completeData = weekDates.map((date) {
      String dateString = date.toIso8601String().split('T').first;
      return dataMap[dateString] ?? {'date': dateString, 'mood': 'Mad','yesCount': 0};
    }).toList();
    return completeData;
  }

  static String getCurrentPhase() {
    String currentPhase = 'morning';
    final now = DateTime.now();
    if (now.hour >= 0 && now.hour < 13) {
      currentPhase = 'Good Morning';
    } else if (now.hour >= 13 && now.hour < 19) {
      currentPhase = 'Good afternoon';
    } else {
      currentPhase = 'Good Evening';
    }
    return currentPhase;
  }


  static Future<void> saveUserData() async {

    var usersRef =await FirebaseFirestore.instance.collection('users').doc(StorageService.getData(StorageKeys.emailId.toString(),""));

    usersRef.get()
        .then((docSnapshot) => {
      if (docSnapshot.exists) {
        StorageService.saveData(StorageKeys.userName.toString(), docSnapshot['name'].toString()),

      } else {

      }
    });



  }
}


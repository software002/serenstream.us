
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:serenestream/utils/permission/permission_util.dart';
import 'package:serenestream/utils/shared_preference_helper.dart';

import '../Constants/AppSizer.dart';
import '../Constants/colors.dart';
import '../Constants/strings.dart';

import '../factory/ImagesFactory.dart';
import 'dart:io';
import 'package:flutter/material.dart';

import '../services/navigator_service.dart';
import 'AppLocalization.dart';



class AppCommonFeatures {
  AppCommonFeatures._privateConstructor();
  static final AppCommonFeatures instance =
  AppCommonFeatures._privateConstructor();

  factory AppCommonFeatures() {
    return instance;
  }

  String APP_VERSION = '1.0.0';

  ImagesFactory imagesFactory = ImagesFactory();
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  AppLocalization appLocalization = AppLocalization();

  bool isProgress = false;
  late BuildContext context;
  int mobile_number_size=8;
  String usersFileLocation="users/";


  // ApiRepository? _apiRepository = null;

  String? fcmToken = '';
 // final String imageBaseUrl = ApiBaseHelper.instance.imageBaseUrl;
  String deviceToken="123456678998765";



  RegExp emailregExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp passwordregex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~\%^.?]).{8,}$');


  RegExp nameRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');

  Future<String> getDeviceToken() async {
    // if (fcmToken == null) {
    //   if (Platform.isIOS) {
    //     fcmToken = await FirebaseMessaging.instance.getToken() ?? await FirebaseMessaging.instance.getAPNSToken() ?? '';
    //   } else {
    //     fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    //   }
    //   print("TOKEN: $fcmToken");
    // }
    // return await fcmToken!;
    return '';
  }

  getFormattedDate(int serverTimeStamp) {
    var timeStamp = serverTimeStamp * 1000;
    var dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    initializeDateFormatting('en','');
    return  DateFormat('dd MMM, yyyy').format(dt);
  }


  getCurrentDate() {
    var dt = DateTime.now();
    initializeDateFormatting('en','');
    return  DateFormat('dd MMM, yyyy').format(dt);
  }

  getDateFromTimeObject(DateTime dateTime) {
    initializeDateFormatting('en','');
    return  DateFormat('dd MMM, yyyy').format(dateTime);
  }

  getDateWeekdayName(DateTime dateTime) {
    return  DateFormat('EEE').format(dateTime);
  }



  showToast(String message, {Toast? toastLength}) {

    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength ?? Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: AppSizer.ten);
  }

  contextInit(BuildContext context) {
    this.context = NavigationService.navigatorKey.currentContext!;
  }

  showCircularProgressDialog() {
    if (!isProgress) {
      isProgress = true;
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return  Dialog(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: SizedBox(
                  width: 55,
                  height: 55,
                  child: Center(
                    heightFactor: 55,
                    widthFactor: 55,
                    child: CircularProgressIndicator(
                      color: AppColors.lightblue,
                    ),
                  )
              ),
            );
          });
    }
  }

  dismissCircularProgressDialog() {
    if (isProgress) {
      Navigator.of(context).pop();
      isProgress = false;
    }
  }

  /*logOutUserSession(){
    sharedPreferenceHelper.forceLogout(context);
  }*/

  sessionExpireLogoutMethod(String msg) {
    PermissionUtil.showActionDialog(
      context: context,
      description: msg,
      shouldShowNegative: false,
      positiveText: Strings.appName,
      onPositiveClick: () async {
      //  logOutUserSession();
      },
    );
  }

  selectDateCubit(BuildContext context, DateTime selectedDate) async {
    var finalDate = '';

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.appColorGreen,
              onPrimary: AppColors.appColor,
              onSurface: AppColors.appColorBlueLight,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null) {
      finalDate = '';
    } else {
      if (selectedDate != picked) selectedDate = picked;
      finalDate = DateFormat('dd MMM,yyyy').format(selectedDate);

    }
    return finalDate;
  }

  String parseDate(DateTime picked){
    String parsed_date=DateFormat('d MMM,yyyy').format(picked);
    return parsed_date;
  }
  String parseTime(DateTime? picked){
    String parsed_time=DateFormat("h:mm a").format(picked!);
    return parsed_time;
  }
}

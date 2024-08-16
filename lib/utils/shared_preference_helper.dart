import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/RouterNavigator.dart';


/// This class is used to handle sharedPreference
class SharedPreferenceHelper {
 static SharedPreferences? sharedPreference;
  String loginDetailsStorageKey = "loginDetails";
  String isIntroShownKey = 'IS_INTRO_SHOWN';
  String accessToken = '';
  String completedStep="completedStep";
  String s3Url = '';
  String firstName = '';
  String lastName = '';
  String fullName = '';
  String avatar = 'userImage';
  String userType = 'userType';
 // String authToken = '';

  SharedPreferenceHelper(){
    getInstance();
  }

  /*Future<String> getToken() async {
    await getLoginUserDetails();
    return accessToken;
  }*/

 int? getCompletedStep()  {
   if(sharedPreference!.containsKey(completedStep)){
     return  sharedPreference!.getInt(completedStep);
   }else{
     return 0;
   }
 }

 void savecompletedStep(int value) async {
    sharedPreference?.setInt(completedStep, value);
 }

 String getUserType()  {
   getInstance();
   String user_type="";
   if(sharedPreference!.containsKey(userType)){
     user_type =  sharedPreference!.getString(userType)!;
   }
   return user_type;
 }

 setUserType(String user_type)  {
   sharedPreference?.setString(userType, user_type);
 }



 /*String getS3Url()  {
    getLoginUserDetails();
   return s3Url;
 }*/
 String getUpdatedAvatarValue()  {
    getInstance();
   String avatar_value="";
   if(sharedPreference!.containsKey(avatar)){
     avatar_value =  sharedPreference!.getString(avatar)!;
   }
   return avatar_value;
 }

  setUpdatedAvatarValue(String avatar_s)  {
    sharedPreference?.setString(avatar, avatar_s);
 }

 static getInstance() async {
    if (sharedPreference != null){
      return sharedPreference;
    }
    return sharedPreference = await SharedPreferences.getInstance();
  }


/*  Future<LoginModel?> getLoginUserDetails() async {
    if (loginModel == null || accessToken == '') {
      await getInstance();
      if(sharedPreference!.containsKey(loginDetailsStorageKey)){
        var userPref = await sharedPreference!.getString(loginDetailsStorageKey)!;

        //userPref="{\"success\":true,\"data\":{\"token\":\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NTM2MTA2MGE1YzFhOGE4OTViZmJmMjEiLCJpYXQiOjE2OTgyMzY4OTQwMDB9.5vkIOsWCV3_OVKpsQMukVSTJJbMl-m1uAqWRMNuKiFg\",\"user\":{\"_id\":\"65361060a5c1a8a895bfbf21\",\"fullName\":\"test\",\"email\":\"test2@yopmail.com\",\"phone\":\"9929320932\",\"avatar\":null,\"deviceToken\":\"123\",\"userName\":\"@testz({@#Pa.\",\"pushNotificationAllowed\":true,\"isShowComplete\":true,\"isEmailVerify\":false,\"isMobileVerify\":false,\"isSuspended\":false,\"isDeleted\":false,\"inviteEmailToken\":\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3QyQHlvcG1haWwuY29tIiwiaWF0IjoxNjk4MDQxOTUyLCJleHAiOjE2OTgwNDkxNTJ9.kgLEdP8egbYSVlXow61NsggBgVzwsxvCBE51PikP_9U\",\"created\":\"2023-10-23T06:19:12.288Z\",\"updated\":\"2023-10-25T12:28:14.305Z\"}},\"message\":\"Logged-In successfully.\"}";
        loginModel = await LoginModel().deserialize(userPref);
        accessToken = loginModel!.data!.token!;
        s3Url = loginModel!.data!.s3Bucket!;
      }
    }
    return loginModel;
  }*/

  Future<void> saveUserDetails(String value) async {
    await sharedPreference?.setString(loginDetailsStorageKey, value);
  }

  Future<void> saveIntro(bool value) async {
    await sharedPreference?.setBool(isIntroShownKey, value);
  }
  Future<bool?> get isIntroShown async{
    await getInstance();
    if(sharedPreference!.containsKey(isIntroShownKey)){
      return sharedPreference!.getBool(isIntroShownKey);
    }else{
      return false;
    }

  }
  /* Future<void> saveAuthtoken(String value) async {
   await sharedPreference?.setString(authToken, value);
 }

 Future<String?> getAuthToken() async {
   await getInstance();
   if(sharedPreference!.containsKey(authToken)){
     return sharedPreference!.getString(authToken);
   }else{
     return "";
   }

 }*/
  ///Clear preference:---------------------------------------------------
  Future<bool> clearPreference() async {
    final value = await sharedPreference?.clear();
    return value ?? false;
  }

/*  forceLogout(BuildContext context) async {
    loginModel = null;
    accessToken='';
    AppCommonFeatures.instance.fcmToken = null;
    await sharedPreference!.remove(loginDetailsStorageKey);
    await sharedPreference!.remove(completedStep);
     Navigator.of(context).pushNamedAndRemoveUntil(
         RouterNavigator.loginScreen, (Route<dynamic> route) => false);
  }*/

}

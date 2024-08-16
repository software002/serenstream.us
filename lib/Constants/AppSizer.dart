
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:serenestream/utils/AppCommonFeatures.dart';

class AppSizer{
  AppSizer._();
  static const double fifteen = 15;
  static const double twenteey = 20;
  static const double twenteeyFour = 24;
  static const double fourteen = 14;
  static const double tweleve = 12;
  static const double three = 3;
  static const double ten = 10;
  static const double one = 1;
  static const double two = 2;
  static const double fourty = 40;
  static const double five = 5;
  static const double hundred = 100;
  static const double eight = 8;
  static const double eighteen = 18;
  static const double fiftysix = 56;
  static const double fifty = 50;
  static const double thirty = 30;
  static const double sixteen = 16;
  static const double one_hundred_eighty = 180;
  static const double one_hundred_twenty = 120;
  static const double two_hundred_fifty = 250;
  static const double one_hund_red_fifty = 150;
  static const double thirteen = 13;
  static const double sixty = 60;
  static const double minus_tweenty = -20;
  static const double eighty = 80;
  static const double ninety = 90;
  static const double ninetyEight = 98;
  static const double thirtySix = 36;
  static const double thirtyfive = 35;
  static const double seventeen = 17;
  static const double fourtyEight = 48;
  static const double seventy = 70;
}


var pixelRatio = window.devicePixelRatio;

//Size in physical pixels
var physicalScreenSize = window.physicalSize;

//Size in logical pixels
var logicalScreenSize = window.physicalSize / pixelRatio;
var screenWidth = logicalScreenSize.width;
//var screenWidth = MediaQuery.of(AppCommonFeatures.instance.context).size.width;
var screenHeight = logicalScreenSize.height;
//var screenHeight = MediaQuery.of(AppCommonFeatures.instance.context).size.height;

//Padding in physical pixels
var padding = window.padding;

//Safe area paddings in logical pixels
var paddingLeft = window.padding.left / window.devicePixelRatio;
var paddingRight = window.padding.right / window.devicePixelRatio;
var paddingTop = window.padding.top / window.devicePixelRatio;
var paddingBottom = window.padding.bottom / window.devicePixelRatio;

//Safe area in logical pixels
var safeWidth = screenWidth - paddingLeft - paddingRight;
var safeHeight = screenHeight - paddingTop - paddingBottom;
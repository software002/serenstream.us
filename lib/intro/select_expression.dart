import 'dart:collection';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:serenestream/Constants/colors.dart';
import 'package:serenestream/auth/screens/login_screen.dart';
import 'package:serenestream/auth/screens/register_screen.dart';
import 'package:serenestream/bloc/login/login_cubit.dart';
import 'package:serenestream/factory/ImagesFactory.dart';
import 'package:serenestream/intro/select_sleep_hours.dart';
import 'package:smooth_carousel_slider_widget/smooth_carousel_slider_widget.dart';

import '../../utils/logx.dart';
import '../Constants/AppSizer.dart';
import '../Constants/assets.dart';
import '../Constants/font_family.dart';
import '../Constants/strings.dart';
import '../common_widgets/custom_button.dart';
import '../services/navigator_service.dart';
import '../utils/AppCommonFeatures.dart';
import '../utils/RouterNavigator.dart';
import '../utils/commonWidget.dart';
import '../utils/util_klass.dart';


class SelectExpressionScreen extends StatefulWidget {
  const SelectExpressionScreen({super.key});

  @override
  State<SelectExpressionScreen> createState() => SelectExpressionScreenState();
}

class SelectExpressionScreenState extends State<SelectExpressionScreen> {
  final CommonWidget commonWidget = CommonWidget();
  TextEditingController emailController = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  late Map<String, dynamic> map;
  bool passwordIsObsecure = true;
  LoginCubit loginCubit=new LoginCubit();
  bool female_select=true;


  final List<String> emoji_texts = [

    Strings.tackling_stress,
    Strings.overcoming_depression,
    'Better Sleep',

  ];

  final List<String> emojies = [
    AppCommonFeatures.instance.imagesFactory.pensive_emo,
    AppCommonFeatures.instance.imagesFactory.tiredFace,
    AppCommonFeatures.instance.imagesFactory.sleep_emo,

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

  }

  init() async {
  //  AppCommonFeatures.instance.contextInit(context);
    map = Map();
  }

  @override
  void dispose() {
    emailController.dispose();
    password_controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        NavigationService.removeKeyboard();
      },
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
          leading:    IconButton(
            iconSize: 24,
            icon: const Icon(
              Icons.arrow_back,
            ),
            // the method which is called
            // when button is pressed
            onPressed: () {
              UtilKlass.navigateScreenOff(LoginScreen());

            },
          ),
            actions: [
              IconButton(
                iconSize: 24,
                icon: const Icon(
                  Icons.close,
                ),
                // the method which is called
                // when button is pressed
                onPressed: () {
                  UtilKlass.navigateScreenOff(LoginScreen());

                },
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizer.fifteen),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSizer.fourtyEight,),
                  commonWidget.title(Strings.what_can_help),
                  SizedBox(height: AppSizer.sixty,),

                  SizedBox(
                  width: ScreenUtil().screenWidth,
                  height: 250.h,
                  child: SmoothCarouselSlider(
                    itemCount: emoji_texts.length,
                    initialSelectedIndex: emoji_texts.length ~/ 2,
                    itemExtent: 160.w,
                    selectedWidget: (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child:
                      commonWidget.cardWithIcon(() {}, true, 200.h, 170.w,20.sp,12.sp, emojies[index],50.w,50.h, emoji_texts[index])
                    ),
                    unSelectedWidget: (index) =>  Container(
                      margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 50.h,bottom: 1.h),
                        child: commonWidget.cardWithIcon(() {}, false, 150.h, 100.w, 10.sp,12.sp, emojies[index],30.w,30.h,emoji_texts[index])),
                    onSelectedItemChanged: (index) => debugPrint('$index'),
                  ),
                ),
                  SizedBox(height: 40.h,),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 60),
                            child: GestureDetector(
                              onTap: () {UtilKlass.navigateScreen(SelectSleepHoursScreen());},

                              child: Image(
                                  width: AppSizer.sixty,
                                  height:AppSizer.sixty ,
                                  image: AssetImage(AppCommonFeatures.instance.imagesFactory.next_icon)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Image(
                                width: AppSizer.eighty,
                                height:AppSizer.twenteey ,
                                image: AssetImage(AppCommonFeatures.instance.imagesFactory.line_express)),
                          ),
                        ],
                      ),
                    ),
                  ),

/*
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: GestureDetector(
                          onTap: () {UtilKlass.navigateScreen(SelectSleepHoursScreen());},

                          child: Image(
                              width: AppSizer.sixty,
                              height:AppSizer.sixty ,
                              image: AssetImage(AppCommonFeatures.instance.imagesFactory.next_icon)),
                        ),
                      ),
                    ),
                  ),
*/

                ],
              ),
            ),
          )),
    );
  }
}

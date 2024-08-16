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
import 'package:serenestream/home/dashboard_screen.dart';
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


class SelectFeelingsScreen extends StatefulWidget {
  const SelectFeelingsScreen({super.key});

  @override
  State<SelectFeelingsScreen> createState() => SelectFeelingsScreenState();
}

class SelectFeelingsScreenState extends State<SelectFeelingsScreen> {
  final CommonWidget commonWidget = CommonWidget();
  TextEditingController emailController = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  late Map<String, dynamic> map;
  bool passwordIsObsecure = true;
  LoginCubit loginCubit=new LoginCubit();
  bool female_select=true;

  final List<String> emoji_texts = [
    'Mad',
    'Normal',
    'Happy',
    'Stress',
    'Sad',

  ];

  final List<String> emojies = [
    AppCommonFeatures.instance.imagesFactory.mad_icon,
    AppCommonFeatures.instance.imagesFactory.normal_icon,
    AppCommonFeatures.instance.imagesFactory.happy_icon,
    AppCommonFeatures.instance.imagesFactory.stress_icon,
    AppCommonFeatures.instance.imagesFactory.sad_icon,

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
                  commonWidget.title(Strings.how_feeling),
                  SizedBox(height: AppSizer.sixty,),

                  SizedBox(
                  width: ScreenUtil().screenWidth,
                  height: 230.h,
                  child: SmoothCarouselSlider(
                    itemCount: emoji_texts.length,
                    initialSelectedIndex: emoji_texts.length ~/ 2,
                    itemExtent: 80.w,
                    selectedWidget: (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20),
                      child:Column(

                        children: [
                          SizedBox(width:80.w,height:50.h,
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.happy_shadow_btn,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                              color: AppColors.happy_shadow_btn,
                            ),
                            child: Center(child: Text(emoji_texts[index],style:TextStyle(
                              fontSize: 10.sp, // Adjust the font size as needed
                              overflow: TextOverflow.visible, // Ensure the text does not overflow
                            ),)),
                          )),
                         Image(
                            height: 80.h,
                            width: 80.w,
                            image: AssetImage(emojies[index]),
                          ),
                        ],
                      ),
                    ),
                    unSelectedWidget: (index) =>
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image(
                                                height: 70.h,
                                                width: 70.w,
                                                image: AssetImage(emojies[index]),
                                              ),
                        ),
                    onSelectedItemChanged: (index) => debugPrint('$index'),
                  ),
                ),
                  Image(
                    width: ScreenUtil().screenWidth,

                    image: AssetImage(AppCommonFeatures.instance.imagesFactory.feel_scale),
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 60),
                            child: GestureDetector(
                              onTap: () {UtilKlass.navigateScreenOffAll(DashboardScreen());},
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
                                image: AssetImage(AppCommonFeatures.instance.imagesFactory.line_feel)),
                          ),
                        ],
                      ),
                    ),
                  ),
                 /* Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: GestureDetector(
                          onTap: () {UtilKlass.navigateScreenOffAll(DashboardScreen());},
                          child: Image(
                              width: AppSizer.sixty,
                              height:AppSizer.sixty ,
                              image: AssetImage(AppCommonFeatures.instance.imagesFactory.next_icon)),
                        ),
                      ),
                    ),
                  ),*/

                ],
              ),
            ),
          )),
    );
  }
}

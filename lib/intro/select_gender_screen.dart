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
import 'package:serenestream/intro/select_expression.dart';

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


class SelectGenderScreen extends StatefulWidget {
  const SelectGenderScreen({super.key});

  @override
  State<SelectGenderScreen> createState() => SelectGenderScreenState();
}

class SelectGenderScreenState extends State<SelectGenderScreen> {
  final CommonWidget commonWidget = CommonWidget();
  TextEditingController emailController = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  late Map<String, dynamic> map;
  bool passwordIsObsecure = true;
  LoginCubit loginCubit=new LoginCubit();
  bool male_select=true;
  bool female_select=false;

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
          leading: IconButton(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSizer.fourtyEight,),
                  commonWidget.title(Strings.chooseGender),
                  commonWidget.title(Strings.gender),
                  SizedBox(height: AppSizer.eighty,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     commonWidget.cardWithIcon(() {
                     male_select ?  setState(() {
                      male_select=false;
                      female_select=true;
                     }): setState(() {
                       male_select=true;
                       female_select=false;
                     });
                     }, male_select, 150.h, 150.w, 20.w,16.sp, AppCommonFeatures.instance.imagesFactory.male_icon, 50.w,50.h,Strings.male),
                     SizedBox(width: 22.w,),
                      commonWidget.cardWithIcon(() {
                        female_select ?  setState(() {
                          female_select=false;
                          male_select=true;
                        }): setState(() {
                          female_select=true;
                          male_select=false;
                        });
                      }, female_select, 150.h, 150.w, 20.w,16.sp,  AppCommonFeatures.instance.imagesFactory.female_icon,50.w,50.h, Strings.female)

                    ],
                  ),

                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        children: [
                          SizedBox(height: 120.h,),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 70),
                            child: GestureDetector(
                              onTap: () {UtilKlass.navigateScreen(SelectExpressionScreen());},
                              child: Image(
                                  width: AppSizer.sixty,
                                  height:AppSizer.sixty ,
                                  image: AssetImage(AppCommonFeatures.instance.imagesFactory.next_icon)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Image(
                                width: AppSizer.eighty,
                                height:AppSizer.twenteey ,
                                image: AssetImage(AppCommonFeatures.instance.imagesFactory.line_gender)),
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
                      onTap: () {UtilKlass.navigateScreen(SelectExpressionScreen());},
                      child: Image(
                          width: AppSizer.sixty,
                          height:AppSizer.sixty ,
                          image: AssetImage(AppCommonFeatures.instance.imagesFactory.next_icon)),
                    ),
                  ),
                ),
              ),
*/
                                           // SocialLoginWidget(loginCubit),
                ],
              ),
            ),
          )),
    );
  }
}

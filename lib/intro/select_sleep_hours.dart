import 'dart:collection';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:serenestream/intro/select_feelings.dart';
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
import '../utils/debug_utils/debug_utils.dart';
import '../utils/util_klass.dart';


class SelectSleepHoursScreen extends StatefulWidget {
  const SelectSleepHoursScreen({super.key});

  @override
  State<SelectSleepHoursScreen> createState() => SelectSleepHoursScreenState();
}

class SelectSleepHoursScreenState extends State<SelectSleepHoursScreen> {
  final CommonWidget commonWidget = CommonWidget();
  final controller = CarouselController();
  int _current = 8;
  TextEditingController emailController = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  late Map<String, dynamic> map;
  bool passwordIsObsecure = true;
  LoginCubit loginCubit=new LoginCubit();
  bool female_select=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

  }
  Widget addImage() {
    late List<SizedBox> imageList = [];
    for(int i=0;i<25;i++){
      imageList.add(

          SizedBox(
              width:  80,
              height:  80,
              child:_current == i ?  ElevatedButton(
                  onPressed: (){
                    setState(() {
                      _current = i;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: AppColors.white,
                    backgroundColor:AppColors.titleColor,
                    minimumSize: Size( 80, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "$i",
                      style: TextStyle(
                        color:Colors.white,
                        fontSize:  22,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )

              ) : GestureDetector(
                onTap: (){
          setState(() {
          _current = i;
          });
          }, child: Center(

                  child: Text(
                    "$i",
                    style: TextStyle(
                      color:AppColors.grayTextcolor,
                      fontSize:  22,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )


          ));
    }



    return Column(
      children: [
        SizedBox(
            height: 80.0,
            width: double.infinity,
            child: CarouselSlider(
                carouselController: controller,
                items: imageList,
                options: CarouselOptions(
                  height: 100,
                  aspectRatio: 2.0,
                  viewportFraction: 0.25,
                  initialPage: 8,
                  enableInfiniteScroll:
                  (imageList.length > 1) ? true : false,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });

                    /*DebugUtils.showLog(
                        'page:$index ${imageList.length - 1}');*/
                  },
                ))


        ),
      ],
    );
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
              padding: const EdgeInsets.symmetric(horizontal: AppSizer.fifteen),
              child:
              Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSizer.fourtyEight,),
                  commonWidget.title(Strings.hours_sleep),
                  SizedBox(height: AppSizer.sixty,),
                  SizedBox(
                      height: 200.0,
                      width: double.infinity,
                      child: addImage()


                  ),
/*
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 80.h,
                      aspectRatio: 16/9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged:null,
                      scrollDirection: Axis.horizontal,),
                    items: [1,2,3,4,5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return commonWidget.cardWithText(() { }, 80.h, 80.w, 28.sp, "$i");
                        },
                      );
                    }).toList(),
                  ),
*/
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        children: [
                          SizedBox(height: 100.h,),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: GestureDetector(
                              onTap: () {UtilKlass.navigateScreen(SelectFeelingsScreen());},
                              child: Image(
                                  width: AppSizer.sixty,
                                  height:AppSizer.sixty,
                                  image: AssetImage(AppCommonFeatures.instance.imagesFactory.next_icon)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Image(
                                width: AppSizer.eighty,
                                height:AppSizer.twenteey ,
                                image: AssetImage(AppCommonFeatures.instance.imagesFactory.line_hour)),
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
                          onTap: () {UtilKlass.navigateScreen(SelectFeelingsScreen());},
                          child: Image(
                              width: AppSizer.sixty,
                              height:AppSizer.sixty,
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

import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:serenestream/Constants/AppSizer.dart';
import 'package:serenestream/auth/screens/register_screen.dart';
import 'package:serenestream/common_widgets/custom_button.dart';
import 'package:serenestream/utils/AppCommonFeatures.dart';
import 'package:serenestream/utils/commonWidget.dart';

import '../../../utils/logx.dart';
import '../../Constants/assets.dart';
import '../../Constants/strings.dart';
import '../../utils/util_klass.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var isApiCalling = false.obs;
  final CountDownController _controller = CountDownController();
  bool passwordIsObsecure = true;
  final _mobileNumberController = TextEditingController();
  final CommonWidget commonWidget = CommonWidget();
  int _currentIndex = 0;
  CarouselController _carouselController = CarouselController();
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    isApiCalling.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTimerPicker(
        onTimerDurationChanged: (value){},
        mode: CupertinoTimerPickerMode.hms,
        initialTimerDuration: Duration(hours: 2,minutes: 50,seconds: 60),
    );
    /*  Column(
      children: [

        *//*commonWidget.countDownTimer(context,_controller),
        SizedBox(height: 80,),
        GestureDetector(
          onTap: ()=>_controller.start(),
            child: commonWidget.pinkButton(() { }, true)),*//*

      ],
    );*/

  }

  /*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.w,
        shadowColor: Colors.grey[100],
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0.w, 20.w, 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 400.0,
                  scrollDirection: Axis.horizontal,
                ),
                items: [1,2,3,4,5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Transform.rotate(
                        angle: index * (2 * math.pi) / 5,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.amber
                            ),
                            child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              CustomButton(label: "Submitting...",onPressed: (){},height:AppSizer.sixty,isLoading: true,),
              commonWidget.title("title"),
              commonWidget.textfield("hintText", TextEditingController(), false),
              commonWidget.passwordTextFieldWithToggle(hintText: "hintText", controller: TextEditingController(), onToggle:(bool isObscure) {
                passwordIsObsecure = isObscure;

              }, )

            ],
          ),
        ),
      ),
    );
  }*/


}

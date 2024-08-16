import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:serenestream/home/dashboard_screen.dart';
import 'package:serenestream/intro/select_expression.dart';
import 'package:serenestream/intro/select_feelings.dart';
import 'package:serenestream/intro/select_gender_screen.dart';
import 'package:serenestream/home/select_music_screen.dart';
import 'package:serenestream/intro/select_sleep_hours.dart';
import 'package:serenestream/meditation/CustomTimerPicker.dart';
import 'package:serenestream/meditation/timer_screen.dart';
import 'package:serenestream/splash/splash_screen.dart';
import 'package:serenestream/utils/util_klass.dart';
import '../Constants/colors.dart';
import '../Constants/font_family.dart';
import '../Constants/strings.dart';
import '../utils/AppCommonFeatures.dart';
import '../utils/RouterNavigator.dart';
import '../utils/WaveClip.dart';
import '../utils/commonWidget.dart';
import '../utils/debug_utils/debug_utils.dart';
import '../home/controller/SalomonBottomBar.dart';

class SetDurationScreen extends StatefulWidget {
  SetDurationScreen({super.key});

  @override
  State<SetDurationScreen> createState() => _SetDurationScreenState();
}

class _SetDurationScreenState extends State<SetDurationScreen>
    with SingleTickerProviderStateMixin {
  final CommonWidget commonWidget = CommonWidget();
  String timer_value = "00:00:00";
  Duration duration = Duration(hours: 0,minutes: 0, seconds:0);
  final controller = CarouselController();
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  init() async {
    //
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonColor,
      appBar: AppBar(
        toolbarHeight: 70.h,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SizedBox(
                width: 36.w,
                height: 36.h,
                child: Image.asset(
                    AppCommonFeatures.instance.imagesFactory.back_blue)),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Choose Your Timer",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp),
        ),
        elevation: 0,
        backgroundColor: AppColors.buttonColor,
      ),
      body: Container(
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 270.h,
                child: CustomTimerPicker(onDurationChanged: (duration_value ) {
                  setState(() {
                    duration = duration_value;
                    timer_value = _printDuration(duration_value);
                  });
                }, initialDuration: duration,

                )/*CupertinoTimerPicker(
                  onTimerDurationChanged: (value) {
                    print(value);
                    setState(() {
                      duration = value;
                      timer_value = _printDuration(value);
                    });
                  },
                  mode: CupertinoTimerPickerMode.hms,
                  initialTimerDuration: Duration(minutes: 50, seconds: 60),
                ),*/
              ),
              SizedBox(
                height: 10.h,
              ),
              Stack(
                children: [
                  Center(
                      child: Image.asset(
                    AppCommonFeatures.instance.imagesFactory.timer_round,
                    height: 140.h,
                    width: 140.w,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Center(
                        child: Text(
                      timer_value,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 60.h,
        margin: const EdgeInsets.all(10),
        child: commonWidget.pinkButton(() {
          if(duration!=Duration(hours: 0,minutes: 0, seconds:0)){
            UtilKlass.navigateScreen(TimerScreen(
              timer_value: duration,
            ));
          }else{
            UtilKlass.showToastMsg(context,"Please set timer");
          }

        }, "Start"),
      ),

    );
  }

  getAppBar() {
    return AppBar(
      leading: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.w,
          ),
          GestureDetector(
            onTap: () => UtilKlass.navigateScreen(DashboardScreen()),
            child: SizedBox(
                width: 36.w,
                height: 36.h,
                child: Image.asset(
                    AppCommonFeatures.instance.imagesFactory.back_blue)),
          ),
        ],
      ),
      title: Center(
          child: Text(
        "Choose your timer",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.sp),
      )),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SizedBox(),
      ),
      backgroundColor: Colors.transparent,
      flexibleSpace: Stack(
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth,
            child: Image.asset(
                AppCommonFeatures.instance.imagesFactory.home_header,
                fit: BoxFit.fill),
          ),
          Column(
            children: [
              SizedBox(
                height: 120,
              ),
              SizedBox(
                  height: 80,
                  width: ScreenUtil().screenWidth,
                  child: Image.asset(
                      AppCommonFeatures.instance.imagesFactory.bg_timer,
                      fit: BoxFit.fill)),
            ],
          )
        ],
      ),
      automaticallyImplyLeading: false,
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,
    );
  }

  String _printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

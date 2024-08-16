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
import 'package:serenestream/intro/select_expression.dart';
import 'package:serenestream/intro/select_feelings.dart';
import 'package:serenestream/intro/select_gender_screen.dart';
import 'package:serenestream/home/select_music_screen.dart';
import 'package:serenestream/intro/select_sleep_hours.dart';
import 'package:serenestream/meditation/set_duration_screen.dart';
import 'package:serenestream/splash/splash_screen.dart';
import '../Constants/colors.dart';
import '../Constants/font_family.dart';
import '../Constants/strings.dart';
import '../utils/AppCommonFeatures.dart';
import '../utils/RouterNavigator.dart';
import '../utils/WaveClip.dart';
import '../utils/commonWidget.dart';
import '../utils/custom_circle_timer/CircularCountDownTimerr.dart';
import '../utils/debug_utils/debug_utils.dart';
import '../home/controller/SalomonBottomBar.dart';
import '../utils/util_klass.dart';

class HoldScreen extends StatefulWidget {
  final Duration timer_value;
  HoldScreen({super.key, required this.timer_value});

  @override
  State<HoldScreen> createState() => _HoldScreenState();
}

class _HoldScreenState extends State<HoldScreen>
    with SingleTickerProviderStateMixin {
  final CommonWidget commonWidget = CommonWidget();
  final CountDownControllerr _controller = CountDownControllerr();

  final controller = CarouselController();
  bool isStart = true;
  bool isPause = false;
  bool isResume = false;
  int _selectedIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    _pages = [Text(""), SelectMusicScreen(), Text(""), Text("")];
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
          "Meditation",
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
              SizedBox(height: 60.h,),
              Center(
                  child: commonWidget.countDownTimer(
                      context, _controller, (widget.timer_value ~/ 3).inSeconds,"hold",widget.timer_value)),
              SizedBox(
                height: 35.h,
              ),
              Center(child: commonWidget.title_breath("Hold")),
              /* SizedBox(height: 100.h,),
                  commonWidget.pinkButton(() { }, false)*/
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Visibility(
                visible: isResume,
                child: commonWidget.pinkButton(() {
                  setState(() {
                    isResume = false;
                    isPause = true;
                    isStart = false;
                    _controller.resume();
                  });
                }, "Resume"),
              ),
              Visibility(
                visible: isPause,
                child: commonWidget.pinkButton(() {
                  setState(() {
                    isResume = true;
                    isPause = false;
                    isStart = false;
                    _controller.pause();
                  });
                }, "Pause"),
              ),
              Visibility(
                visible: isStart,
                child: commonWidget.pinkButton(() {
                  setState(() {
                    isResume = false;
                    isPause = true;
                    isStart = false;
                    _controller.start();
                  });
                }, "Start"),
              ),
            ],
          )),
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
            onTap: () => UtilKlass.navigateScreen(SetDurationScreen()),
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
        "Meditation",
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
}

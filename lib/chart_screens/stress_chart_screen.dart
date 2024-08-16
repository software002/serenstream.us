import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:serenestream/Constants/AppSizer.dart';
import 'package:serenestream/Constants/colors.dart';
import 'package:serenestream/home/dashboard_screen.dart';
import 'package:serenestream/meditation/timer_screen.dart';
import 'package:serenestream/utils/util_klass.dart';
import '../utils/AppCommonFeatures.dart';
import '../utils/WaveClip.dart';
import '../utils/commonWidget.dart';
import 'package:bubble_chart/bubble_chart.dart';


class StressChart extends StatefulWidget {
  StressChart({super.key});

  @override
  State<StressChart> createState() => _StressChartState();
}

class _StressChartState extends State<StressChart>{
  final CommonWidget commonWidget = CommonWidget();
  List<BubbleNode> childNode = [];
  late Future<List<Map<String, dynamic>>> _weeklyMoods;


  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
    _weeklyMoods = UtilKlass.fetchCurrentWeekData().then((data) => UtilKlass.mergeWithDefaultData(data));

  }

  List<BubbleNode> _prepareBubbleNodes(List<Map<String, dynamic>> data) {
    List<BubbleNode> nodes = [];
    num happyCount=0;
    double happyVal=15;
    num sadCount=0;
    double sadVal=15;
    num normalCount=0;
    double normalVal=15;
    num madCount=0;
    double madVal=15;
    num yesCount =0;
    double valuee =15;
    for (var moodData in data) {
     /* var date = moodData['date'];
      var mood = moodData['mood'];
     var valuee = yesCount==0 ? 15 : yesCount.toDouble();
      var color = _getBubbleColor(mood);*/

      yesCount=yesCount+moodData['yesCount'] ?? 0;
      valuee = yesCount==0 ? 15 : yesCount.toDouble()*10;

    }
    if (yesCount >= 11) {
      happyCount=yesCount;
      happyVal=valuee;
    } else if (yesCount >= 8) {
      normalCount=yesCount;
      normalVal=valuee;
    } else if (yesCount >= 6) {
      sadCount=yesCount;
      sadVal=valuee;
    } else {
      madCount=yesCount;
      madVal=valuee;
    }

    nodes.add(
      BubbleNode.node(
          children: [
            BubbleNode.leaf(
                value: happyVal,
                options: BubbleOptions(
                    child:Center(child: Text("${happyCount}",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: happyCount==0?20:happyCount*4,
                    ),),),
                    color: AppColors.happy_color
                )
            ),

          ]
      ),

    );
    nodes.add(
      BubbleNode.node(
          children: [
            BubbleNode.leaf(
                value: sadVal,
                options: BubbleOptions(
                    child:Center(child: Text("${sadCount}",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: sadCount==0?20:sadCount*4,
                    ),),),
                    color: AppColors.sad_color
                )
            ),

          ]
      ),

    );
    nodes.add(
      BubbleNode.node(
          children: [
            BubbleNode.leaf(
                value: normalVal,
                options: BubbleOptions(
                    child:Center(child: Text("${normalCount}",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: normalCount==0?20:normalCount*4,
                    ),),),
                    color: AppColors.normal_color
                )
            ),

          ]
      ),

    );
    nodes.add(
      BubbleNode.node(
          children: [
            BubbleNode.leaf(
                value: madVal,
                options: BubbleOptions(
                    child:Center(child: Text("${madCount}",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: madCount==0?20:madCount*4,
                    ),),),
                    color: AppColors.mad_color
                )
            ),

          ]
      ),

    );

    return nodes;
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
          onTap:()=> Get.back(),
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
        title:Text(
          "Stress Level Stats",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.sp),
        ),
        elevation: 0,
        backgroundColor: AppColors.buttonColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizer.twenteeyFour),
          child: Column(
            children: [
              SizedBox(height: 40.h,),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizer.fourty),
                child: SizedBox(
                  height: 20.h,
                  width: ScreenUtil().screenWidth,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      colorHelp(AppColors.happy_color, "Happy"),
                                Spacer(),
                       colorHelp(AppColors.normal_color, "Normal"), Spacer(),
                      colorHelp(AppColors.mad_color, "Mad"),     Spacer(),
                                          colorHelp(AppColors.sad_color, "Sad"),
                      Spacer(),

                    ],),
                ),
              ),
              Center(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _weeklyMoods,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No mood data for this week.'));
                    } else {
                      List<Map<String, dynamic>> moods = snapshot.data!;
                      List<BubbleNode> bubbleNodes = _prepareBubbleNodes(moods);

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          height: 400,
                          child: BubbleChartLayout(
                            children: bubbleNodes,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),



     // BubbleChartLayout(children:root)


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
            onTap:()=> UtilKlass.navigateScreen(DashboardScreen()),
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
        "Stress Level Stats",
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
                height: 109,
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
Widget colorHelp(var color,var text){
    return Row(children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color),
      ),
      Text("  $text",style: TextStyle(fontSize: AppSizer.sixteen,color: AppColors.blackshade,fontWeight: FontWeight.w500),)

    ],);
}

}

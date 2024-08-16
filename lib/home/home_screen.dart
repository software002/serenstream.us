import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:serenestream/Constants/colors.dart';
import 'package:serenestream/chart_screens/stress_chart_screen.dart';
import 'package:serenestream/meditation/set_duration_screen.dart';
import 'package:serenestream/utils/util_klass.dart';

import '../Constants/AppSizer.dart';
import '../Constants/strings.dart';
import '../services/navigator_service.dart';
import '../utils/AppCommonFeatures.dart';
import '../utils/commonWidget.dart';
import '../utils/storage_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final CommonWidget commonWidget = CommonWidget();
  String  streakCount="";
  String  sessionCount="";
  DateTime _currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<DateTime> _currentWeekDates = [];
  String mood_mon=AppCommonFeatures.instance.imagesFactory.normal_comp;
  String mood_tues=AppCommonFeatures.instance.imagesFactory.normal_comp;
  String mood_thurs=AppCommonFeatures.instance.imagesFactory.normal_comp;
  String mood_wed=AppCommonFeatures.instance.imagesFactory.normal_comp;
  String mood_fri=AppCommonFeatures.instance.imagesFactory.normal_comp;
  String mood_sat=AppCommonFeatures.instance.imagesFactory.normal_comp;
  String mood_sun=AppCommonFeatures.instance.imagesFactory.normal_comp;
  bool _weekChanged = false;

  final List<String> tips = [
    "Focus on things you can see, hear, smell, taste or touch.",
    "Whether you’re feeling bored, sad, irritated, angry or frustrated give relaxed attention to the emotion.",
    "Start your morning with writing or wind up the day on the page. Focus on sensory details. Or write about your life as a passive observer. ",
    "Rather than trying to draw something in particular, focus on the colours and the sensation of your pencil against the paper. ",
    "This involves sitting quietly to focus on your breathing, thoughts, sensations in your body or things you can sense around you. ",
    "Try to bring your attention back to the present if your mind starts to wander. ",
    "When your mind wanders, which is just what minds do, simply notice where your thoughts have drifted to.  ",
    "Notice and be aware of the emotions you are feeling or sensations in your body. ",
    "Choose to bring your attention back to the present moment. You could do this by focusing on your breathing or another sensation in your body. ",
    "Remember that mindfulness can be difficult and our minds will always wander. Try not to be critical of yourself. ",
    "Regular, short periods of mindfulness can work better than occasional long ones.  ",
    "It can help to do mindfulness in a space where you feel safe, comfortable and won't be easily distracted. ",
    "Try to build up your practice bit by bit. You don't need to set ambitious goals or put pressure on yourself.  ",
    "Focus on things you can see, hear, smell, taste or touch.",
    "Whether you’re feeling bored, sad, irritated, angry or frustrated give relaxed attention to the emotion.",
    "Start your morning with writing or wind up the day on the page. Focus on sensory details. Or write about your life as a passive observer. ",
    "Rather than trying to draw something in particular, focus on the colours and the sensation of your pencil against the paper. ",
    "This involves sitting quietly to focus on your breathing, thoughts, sensations in your body or things you can sense around you. ",
    "Try to bring your attention back to the present if your mind starts to wander. ",
    "When your mind wanders, which is just what minds do, simply notice where your thoughts have drifted to.  ",
    "Notice and be aware of the emotions you are feeling or sensations in your body. ",
    "Choose to bring your attention back to the present moment. You could do this by focusing on your breathing or another sensation in your body. ",
    "Remember that mindfulness can be difficult and our minds will always wander. Try not to be critical of yourself. ",
    "Regular, short periods of mindfulness can work better than occasional long ones.  ",
    "It can help to do mindfulness in a space where you feel safe, comfortable and won't be easily distracted. ",
    "Try to build up your practice bit by bit. You don't need to set ambitious goals or put pressure on yourself.  ",
    "Focus on things you can see, hear, smell, taste or touch.",
    "Whether you’re feeling bored, sad, irritated, angry or frustrated give relaxed attention to the emotion.",
    "Start your morning with writing or wind up the day on the page. Focus on sensory details. Or write about your life as a passive observer. ",
    "Rather than trying to draw something in particular, focus on the colours and the sensation of your pencil against the paper. ",
    "This involves sitting quietly to focus on your breathing, thoughts, sensations in your body or things you can sense around you. ",
    "Try to bring your attention back to the present if your mind starts to wander. ",
    "When your mind wanders, which is just what minds do, simply notice where your thoughts have drifted to.  ",
    "Notice and be aware of the emotions you are feeling or sensations in your body. ",
    "Choose to bring your attention back to the present moment. You could do this by focusing on your breathing or another sensation in your body. ",
    "Remember that mindfulness can be difficult and our minds will always wander. Try not to be critical of yourself. ",
    "Regular, short periods of mindfulness can work better than occasional long ones.  ",
    "It can help to do mindfulness in a space where you feel safe, comfortable and won't be easily distracted. ",
    "Try to build up your practice bit by bit. You don't need to set ambitious goals or put pressure on yourself.  ",
    "Focus on things you can see, hear, smell, taste or touch.",
    "Whether you’re feeling bored, sad, irritated, angry or frustrated give relaxed attention to the emotion.",
    "Start your morning with writing or wind up the day on the page. Focus on sensory details. Or write about your life as a passive observer. ",
    "Rather than trying to draw something in particular, focus on the colours and the sensation of your pencil against the paper. ",
    "This involves sitting quietly to focus on your breathing, thoughts, sensations in your body or things you can sense around you. ",
    "Try to bring your attention back to the present if your mind starts to wander. ",
    "When your mind wanders, which is just what minds do, simply notice where your thoughts have drifted to.  ",
    "Notice and be aware of the emotions you are feeling or sensations in your body. ",
    "Choose to bring your attention back to the present moment. You could do this by focusing on your breathing or another sensation in your body. ",
    "Remember that mindfulness can be difficult and our minds will always wander. Try not to be critical of yourself. ",
    "Regular, short periods of mindfulness can work better than occasional long ones.  ",
    "It can help to do mindfulness in a space where you feel safe, comfortable and won't be easily distracted. ",
    "Try to build up your practice bit by bit. You don't need to set ambitious goals or put pressure on yourself.  ",


  ];
  var random_tip="Consider setting an intention before meditating, maybe it’s self-kindness, openness or patience.";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    int randomIndex = Random().nextInt(tips.length);
    random_tip=tips[randomIndex];
    _updateCurrentWeekDates();

    _setMoods();
    addStreak();
    streakCount="${UtilKlass.giveStreakData(UtilKlass.getCurrentDate())}";
    debugPrint("%%%%%%%%%%%%%%%session$streakCount");
   sessionCount="${UtilKlass.giveSessionData(UtilKlass.getCurrentDate())}";


  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //NavigationService.removeKeyboard();
      },
      child: Scaffold(
          backgroundColor: AppColors.bgColorDash,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: commonWidget.dashTitle("Hows your mood today?"),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: AppSizer.twenteey),
                  height: 120.h,
                  width: ScreenUtil().screenWidth,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: commonWidget.cardAndIcon(
                              () {
                            UtilKlass.showProgressAppLoading(context);
                            var userMood = <String, dynamic>{
                              "email": StorageService.getData(StorageKeys.emailId.toString(),""),
                              "mood": "Happy",
                              "createdDate": UtilKlass.getCurrentDate()
                            };
                            UtilKlass.addMoodDataInFirestore(userMood, UtilKlass.getCurrentDate(), StorageService.getData(StorageKeys.emailId.toString(),""),context);
                            Future.delayed(const Duration(milliseconds: 1000), () {
                              setState(() {
                                _setMoods();
                              });

                            });

                          },
                          false,
                          60.h,
                          ScreenUtil().screenWidth * 0.25,
                          10.sp,
                          12.sp,
                          AppCommonFeatures.instance.imagesFactory.happy_comp,
                          20.w,
                          20.h,
                          Strings.happy,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: commonWidget.cardAndIcon(
                              () {
                            UtilKlass.showProgressAppLoading(context);
                            var userMood = <String, dynamic>{
                              "email": StorageService.getData(StorageKeys.emailId.toString(),""),
                              "mood": "Sad",
                              "createdDate": UtilKlass.getCurrentDate()
                            };
                            UtilKlass.addMoodDataInFirestore(userMood, UtilKlass.getCurrentDate(), StorageService.getData(StorageKeys.emailId.toString(),""),context);
                            Future.delayed(const Duration(milliseconds: 1000), () {
                              setState(() {
                                _setMoods();
                              });

                            });

                          },
                          false,
                          60.h,
                          ScreenUtil().screenWidth * 0.25,
                          10.sp,
                          12.sp,
                          AppCommonFeatures.instance.imagesFactory.sad_comp,
                          20.w,
                          20.h,
                          Strings.sad,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: commonWidget.cardAndIcon(
                              () {
                            UtilKlass.showProgressAppLoading(context);
                            var userMood = <String, dynamic>{
                              "email": StorageService.getData(StorageKeys.emailId.toString(),""),
                              "mood": "Normal",
                              "createdDate": UtilKlass.getCurrentDate()
                            };
                            UtilKlass.addMoodDataInFirestore(userMood, UtilKlass.getCurrentDate(), StorageService.getData(StorageKeys.emailId.toString(),""),context);

                            Future.delayed(const Duration(milliseconds: 1000), () {
                              setState(() {
                                _setMoods();
                              });

                            });

                            },
                          false,
                          60.h,
                          ScreenUtil().screenWidth * 0.25,
                          10.sp,
                          12.sp,
                          AppCommonFeatures.instance.imagesFactory.normal_comp,
                          20.w,
                          20.h,
                          Strings.normal,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: commonWidget.cardAndIcon(
                              () {
                            UtilKlass.showProgressAppLoading(context);
                            var userMood = <String, dynamic>{
                              "email": StorageService.getData(StorageKeys.emailId.toString(),""),
                              "mood": "Mad",
                              "createdDate": UtilKlass.getCurrentDate()
                            };
                            UtilKlass.addMoodDataInFirestore(userMood, UtilKlass.getCurrentDate(), StorageService.getData(StorageKeys.emailId.toString(),""),context);
                            Future.delayed(const Duration(milliseconds: 1000), () {
                              setState(() {
                                _setMoods();
                              });

                            });
                              },
                          false,
                          60.h,
                          ScreenUtil().screenWidth * 0.25,
                          10.sp,
                          12.sp,
                          AppCommonFeatures.instance.imagesFactory.mad_comp,
                          20.w,
                          20.h,
                          Strings.mad,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().screenWidth,
                  color: AppColors.white,
                  height: 150.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: commonWidget.dashTitle("Your Stats"),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        child: Container(
                          height: 70.h,
                          width: ScreenUtil().screenWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex:1,

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: ScreenUtil().screenWidth*0.50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.lightpinkbox,
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      color: AppColors.lightpinkbox,
                                    ),
                                    child: Row(
                                        children: [
                                          SizedBox(width: 15.w,),
                                          Center(
                                            child: Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.session_im),height: 30.h,
                                              width: 30.w,),
                                          ),
                                           Expanded(
                                             child: Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                children: [
                                                  Text("Sessions",style: TextStyle(fontSize: AppSizer.fourteen,fontWeight: FontWeight.w400),),
                                                  FutureBuilder<int>(
                                                    future: UtilKlass.giveSessionData(UtilKlass.getCurrentDate(),
                                                    ), builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return CircularProgressIndicator();
                                                    } else if (snapshot.hasError) {
                                                      return Text('0');
                                                    } else if (!snapshot.hasData) {
                                                      return Text('0');
                                                    } else {
                                                      return Text(' ${snapshot.data}',style: TextStyle(fontSize: AppSizer.eighteen,fontWeight: FontWeight.w600),);
                                                    } },
                                                  ),
                                                ],
                                              ),
                                                                                       ),
                                           )
                                        ]

                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:1,

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: ScreenUtil().screenWidth*0.50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.lightpinkbox,
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      color: AppColors.lightpinkbox,
                                    ),
                                    child: Row(
                                        children: [
                                          SizedBox(width: 15.w,),
                                          Center(
                                            child: Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.streak_im),height: 30.h,
                                              width: 30.w,),
                                          ),
                                           Expanded(
                                             child: Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                children: [
                                                  Text(style: TextStyle(fontSize: AppSizer.fourteen,fontWeight: FontWeight.w400),"Streak"),
                                                                                 FutureBuilder<int>(
                                                                                   future: UtilKlass.giveStreakData(UtilKlass.getCurrentDate(),
                                                                                 ), builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                                                                     if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                   return CircularProgressIndicator();
                                                                                 } else if (snapshot.hasError) {
                                                                                   return Text('0');
                                                                                 } else if (!snapshot.hasData) {
                                                                                   return Text('0');
                                                                                 } else {
                                                                                   return Text(' ${snapshot.data}',style: TextStyle(fontSize: AppSizer.eighteen,fontWeight: FontWeight.w600),);
                                                                                 } },
                                                                               ),
                                                 // Text(style: TextStyle(fontSize: AppSizer.eighteen,fontWeight: FontWeight.w600),"$streakCount")
                                             
                                                ],
                                              ),
                                                                                       ),
                                           )
                                        ]

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                Container(
                  width: ScreenUtil().screenWidth,
                  height: 240.h,
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: commonWidget.dashTitle("Weekly Mood"),
                      ),
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(style: TextStyle(fontWeight: FontWeight.w400,fontSize: AppSizer.fourteen,color: AppColors.blackshade),'${_formatWeekRange()}',),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                width: ScreenUtil().screenWidth*0.40 ,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.pinkColor,
                                    foregroundColor: AppColors.pinkColor,
                                    shadowColor: AppColors.pinkColor,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppSizer.hundred)),
                                  ),
                                  onPressed: () {
                                    _goToPreviousWeek();
                                  },
                                  child: Text( "Previous Week" ,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12)),
                                ),
                              ),
                            ),
                            Expanded(flex:1,child: SizedBox(width: ScreenUtil().screenWidth*0.20 ,)),
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: ScreenUtil().screenWidth*0.40 ,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.pinkColor,
                                    foregroundColor: AppColors.pinkColor,
                                    shadowColor: AppColors.pinkColor,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppSizer.hundred)),
                                  ),
                                  onPressed: () {
                                     _weekChanged ? _goToNextWeek() : null;
                                  },
                                  child: const Text( "Next Week" ,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ),
                              ),
                            ),
            
            
                          ],
                        ),
                      ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       child: Container(
                         width: ScreenUtil().screenWidth,
                         height: 90.h,
                         decoration: BoxDecoration(
                             border: Border.all(
                               color: AppColors.lightpinkbox,
                             ),
                             borderRadius: BorderRadius.all(Radius.circular(15)),
                           color: AppColors.lightpinkbox,
                         ),
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.stretch,
                             children: [
                               Expanded(
                                 flex:1,
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 10),
                                   child: Column(
            
                                     children: [

                                    //   Image(image: AssetImage(UtilKlass.printMoodSync(_currentWeekDates[0])),width: 26.w,height: 26.h,),
                                       Image(image: AssetImage(mood_sun),width: 26.w,height: 26.h,),
                                       SizedBox(height: 13.h,) ,
                                       const Text("Sun",style: TextStyle(fontSize: 12),),
                                     ],
                                   ),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 10),
                                 child: Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.line_im),height: 22,
                                   width: 22,),
            
                               ),
                               Expanded(
                                 flex:1,
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 10),
                                   child: Column(
            
                                     children: [
                                       Image(image: AssetImage(mood_mon),width: 26.w,height: 26.h,),
                                       SizedBox(height: 13.h,) ,
                                       const Text("Mon",style: TextStyle(fontSize: 12),),
                                     ],
                                   ),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 10),
                                 child: Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.line_im),height: 22,
                                   width: 22,),
            
                               ),
                               Expanded(
                                 flex:1,
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 10),
                                   child: Column(
            
                                     children: [
                                       Image(image: AssetImage(mood_tues),width: 26.w,height: 26.h,),
                                       SizedBox(height: 13.h,) ,
                                       const Text("Tue",style: TextStyle(fontSize: 12),),
                                     ],
                                   ),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 10),
                                 child: Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.line_im),height: 22,
                                   width: 22,),
            
                               ),
                               Expanded(
                                 flex:1,
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 10),
                                   child: Column(
            
                                     children: [
                                       Image(image: AssetImage(mood_wed),width: 26.w,height: 26.h,),
                                       SizedBox(height: 13.h,) ,
                                       const Text("Wed",style: TextStyle(fontSize: 12),),
                                     ],
                                   ),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 10),
                                 child: Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.line_im),height: 22,
                                   width: 22,),
            
                               ),
                               Expanded(
                                 flex:1,
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 10),
                                   child: Column(
            
                                     children: [
                                       Image(image: AssetImage(mood_thurs),width: 26.w,height: 26.h,),
                                       SizedBox(height: 13.h,) ,
                                       const Text("Thu",style: TextStyle(fontSize: 12),),
                                     ],
                                   ),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 10),
                                 child: Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.line_im),height: 22,
                                   width: 22,),
            
                               ),
                               Expanded(
                                 flex:1,
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 10),
                                   child: Column(
            
                                     children: [
                                       Image(image: AssetImage(mood_fri),width: 26.w,height: 26.h,),
                                       SizedBox(height: 13.h,) ,
                                       const Text("Fri",style: TextStyle(fontSize: 12),),
                                     ],
                                   ),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 10),
                                 child: Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.line_im),height: 22,
                                   width: 22,),
            
                               ),
                               Expanded(
                                 flex:1,
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 10),
                                   child: Column(
            
                                     children: [
                                       Image(image: AssetImage(mood_sat),width: 26.w,height: 26.h,),
                                       SizedBox(height: 13.h,) ,
                                       const Text("Sat",style: TextStyle(fontSize: 12),),
                                     ],
                                   ),
                                 ),
                               ),
            
                             ],
                           ),
                         ),
                       ),
                     ),
            
                    ],
            
                  ),
                ),
                SizedBox(height: 30.h,),
                Container(
                  width: ScreenUtil().screenWidth,
                  height: 160.h,
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: commonWidget.dashTitle("More Features"),
                    ),
                    SizedBox(height: 8.h,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onTap:()=> UtilKlass.navigateScreen(SetDurationScreen()),
                        child:Container(
                          height: 110.h, // Adjust the height to match the content's height
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    Image(
                                      image: AssetImage(AppCommonFeatures.instance.imagesFactory.more_bg_im),
                                      width: 230.w,
                                      height: 110.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(30),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Sleep",
                                            style: TextStyle(
                                              color: AppColors.pinkColor,
                                              fontSize: AppSizer.tweleve,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Text(
                                            "Oceans",
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: AppSizer.sixteen,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage(AppCommonFeatures.instance.imagesFactory.clock_im),
                                                height: 11,
                                                width: 11,
                                              ),
                                              SizedBox(width: 3.w),
                                              const Text(
                                                "Meditation - 15m 4s",
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 15.w),
                                Stack(
                                  children: [
                                    InkWell(
                                      onTap:(){
                               UtilKlass.navigateScreen(StressChart());
                      },
                                      child: Image(
                                        image: AssetImage(AppCommonFeatures.instance.imagesFactory.stress_im),
                                        width: 230.w,
                                        height: 110.h,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(30),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(AppCommonFeatures.instance.imagesFactory.clock_im),
                                              height: 11,
                                              width: 11,
                                            ),
                                            SizedBox(width: 3.w),
                                            const Text(
                                              "Stress level stats",
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        /* Row(
                          children: [
                            Stack(children: [
                              Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.more_bg_im),width: 230.w,height: 110.h,),
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text("Sleep",  style: TextStyle(
                                        color: AppColors.pinkColor,
                                        fontSize: AppSizer.tweleve,
                                        fontWeight: FontWeight.w500)),
                                    const Text("Oceans",  style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: AppSizer.sixteen,
                                        fontWeight: FontWeight.w600)),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      children: [
                                        Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.clock_im),height: 11,
                                          width: 11,),
                                        SizedBox(width: 3.w,),
                                        const Text("Meditation - 15m 4s",  style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400)),
                                      ],
                                    ),

                                  ],
                                ),
                              )
                            ],),
                            SizedBox(width: 15.w,),
                            Stack(children: [
                              Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.stress_im),width: 230.w,height: 110.h,),
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child:   Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    children: [
                                      Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.clock_im),height: 11,
                                        width: 11,),
                                      SizedBox(width: 3.w,),
                                      const Text("Meditation - 15m 4s",  style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              )
                            ],),
                          ],
                        ),*/
                      ),
                    ),
                  ],),
                ),
                SizedBox(height: 30.h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child:GestureDetector(
                    onTap:()=> UtilKlass.navigateScreen(SetDurationScreen()),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: AppColors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(children: [
                              Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.bulb_im),height: 35.h,
                                width: 35.w,),
                              SizedBox(width: 20.w,),
                              const Text("Mindful tip", style: TextStyle(
                                  color:Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500)),

                            ],),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child:  Text(style: TextStyle(
                                  color:AppColors.blackshade,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),random_tip),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h,),
               /*

                Container(
                 decoration: BoxDecoration(
                     border: Border.all(
                       color: Colors.white,
                     ),
                     borderRadius: BorderRadius.all(Radius.circular(15))
                 ),
                 child: Column(
                   children: [
                     Row(children: [
                       Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.bulb_im),height: 22,
                         width: 22,),
                       const Text("Mindful tip"),
            
                     ],),
                     const Text("Consider setting an intention before meditating, maybe it’s self-kindness, openness or patience.")
                   ],
                 ),
               )*/
              ],
            ),
          )),
    );
  }



  ///////////////////////////////////////methods

  String getCurrentDay(){
    DateTime nowWithTime = DateTime.now();
    return "${nowWithTime.day}";
  }

  Future<void> addStreak() async {
    DateTime? latestDocumentDate;
    Duration? dateDifference;
    var streakData=0;

    FirebaseFirestore.instance
        .collection('UserStats')
        .limit(1)
        .get()
        .then((checkSnapshot) async {
      if (checkSnapshot.size == 0) {
        print("inif*****");
        var userStats = <String, dynamic>{
          "email": StorageService.getData(StorageKeys.emailId.toString(),""),
          "streak": 1,
          "createdDate":UtilKlass.getCurrentDate()
        };
        UtilKlass.addUserStatsDataInFirestore(userStats,UtilKlass.getCurrentDate(),StorageService.getData(StorageKeys.emailId.toString(),""));
      }else{
        print("inelse*****");
        try {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('UserStats')
              .orderBy('createdDate', descending: true)
              .limit(1)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            DocumentSnapshot latestDocument = querySnapshot.docs.first;
            Timestamp timestamp = latestDocument['createdDate'];
            latestDocumentDate = timestamp.toDate();
            dateDifference = DateTime.now().difference(latestDocumentDate!);
            streakData = latestDocument['streak'];
          }
        } catch (e) {
          print('Error fetching latest document: $e');
        }
        if(dateDifference!.inDays==1){
          streakData=streakData+1;
        }else if(dateDifference!.inDays>1){
          streakData=0;
        }else{
          streakData=1;
        }
        var userStats = <String, dynamic>{
          "email": StorageService.getData(StorageKeys.emailId.toString(),""),
          "streak": streakData,
          "createdDate":UtilKlass.getCurrentDate()
        };
        UtilKlass.addUserStatsDataInFirestore(userStats,UtilKlass.getCurrentDate(),StorageService.getData(StorageKeys.emailId.toString(),""));
      }
    });


  }
  void _setMoods(){
    UtilKlass.giveWeekDayMood(_currentWeekDates[0]).then((mood) {
      Future.delayed(const Duration(milliseconds: 500), () {
        mood==""?AppCommonFeatures.instance.imagesFactory.normal_comp: mood;
        mood_mon=mood;

        debugPrint("kkkkkkkkkkkkkmon");
        debugPrint("$mood${_currentWeekDates[0].year}${_currentWeekDates[0].month}${_currentWeekDates[0].day}");

      });

    });
    UtilKlass.giveWeekDayMood(_currentWeekDates[1]).then((mood) {
      Future.delayed(const Duration(milliseconds: 500), () {
        mood==""?AppCommonFeatures.instance.imagesFactory.normal_comp: mood;
        mood_tues=mood;
        setState(() {

        });
        debugPrint("kkkkkkkkkkkkktues");
        debugPrint("$mood${_currentWeekDates[1].year}${_currentWeekDates[1].month}${_currentWeekDates[1].day}");

      });


    });
    UtilKlass.giveWeekDayMood(_currentWeekDates[2]).then((mood) {
      Future.delayed(const Duration(milliseconds: 500), () {
        mood==""?AppCommonFeatures.instance.imagesFactory.normal_comp: mood;
        mood_wed=mood;
        debugPrint("kkkkkkkkkkkkkwed");
        debugPrint("$mood${_currentWeekDates[2].year}${_currentWeekDates[2].month}${_currentWeekDates[2].day}");

      });
    });
    UtilKlass.giveWeekDayMood(_currentWeekDates[3]).then((mood) {
      Future.delayed(const Duration(milliseconds: 500), () {
        mood ==""?AppCommonFeatures.instance.imagesFactory.normal_comp: mood;
        mood_thurs=mood;
        debugPrint("kkkkkkkkkkkkkthurs");
        debugPrint("$mood${_currentWeekDates[3].year}${_currentWeekDates[3].month}${_currentWeekDates[3].day}");

      });

    });
    UtilKlass.giveWeekDayMood(_currentWeekDates[4]).then((mood) {
      Future.delayed(const Duration(milliseconds: 500), () {
        mood==""?AppCommonFeatures.instance.imagesFactory.normal_comp: mood;
        mood_fri=mood;
        debugPrint("kkkkkkkkkkkkkfri");
        debugPrint("$mood${_currentWeekDates[4].year}${_currentWeekDates[4].month}${_currentWeekDates[4].day}");


    }); });
    UtilKlass.giveWeekDayMood(_currentWeekDates[5]).then((mood) {
      Future.delayed(const Duration(milliseconds: 500), () {
        mood==""?AppCommonFeatures.instance.imagesFactory.normal_comp: mood;
        mood_sat=mood;
        debugPrint("kkkkkkkkkkkkksat");
        debugPrint("$mood${_currentWeekDates[5].year}${_currentWeekDates[5].month}${_currentWeekDates[5].day}");

      });


    });
    UtilKlass.giveWeekDayMood(_currentWeekDates[6]).then((mood) {
      Future.delayed(const Duration(milliseconds: 500), () {
        mood==""?AppCommonFeatures.instance.imagesFactory.normal_comp: mood;
        mood_sun=mood;
        debugPrint("kkkkkkkkkkkkksun");
        debugPrint("$mood${_currentWeekDates[6].year}${_currentWeekDates[6].month}${_currentWeekDates[6].day}");

      });


    });
    setState(() {

    });
  }

  void _updateCurrentWeekDates() {
    DateTime firstDayOfWeek = _currentDate.subtract(Duration(days: _currentDate.weekday - 1));
    _currentWeekDates = List.generate(7, (index) => firstDayOfWeek.add(Duration(days: index)));
    print(_currentWeekDates.map((e) => e));
    print("mood****3*${_currentWeekDates[0]}");
    print("mood****4*${UtilKlass.giveWeekDayMood(_currentWeekDates[0])}");
    _setMoods();
  }
  void _goToPreviousWeek() {
    setState(() {
      _currentDate = _currentDate.subtract(Duration(days: 7));
      _updateCurrentWeekDates();
      _weekChanged = true; // Always set _weekChanged to true when pressing "Previous Week" button
    });
  }

  void _goToNextWeek() {
    if (_weekChanged && !_isCurrentWeek()) {
      setState(() {
        _currentDate = _currentDate.add(Duration(days: 7));
        _updateCurrentWeekDates();
        _weekChanged = true;
      });
    }
  }
  String _formatWeekRange() {
    DateTime firstDayOfWeek = _currentWeekDates.first;
    DateTime lastDayOfWeek = _currentWeekDates.last;
    String formattedFirstDay = DateFormat('MMM d').format(firstDayOfWeek);
    String formattedLastDay = DateFormat('d').format(lastDayOfWeek);
    return '$formattedFirstDay-$formattedLastDay';
  }
  bool _isCurrentWeek() {
    DateTime nowWithTime = DateTime.now();
    DateTime now = DateTime(nowWithTime.year, nowWithTime.month, nowWithTime.day);
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
    return _currentDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
        _currentDate.isBefore(endOfWeek.add(Duration(days: 1)));
  }
}

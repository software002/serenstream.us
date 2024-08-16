import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Constants/AppSizer.dart';
import '../Constants/colors.dart';
import '../Constants/font_family.dart';
import '../utils/AppCommonFeatures.dart';



enum ProgressStatus {
  incomplete,
  inProgress,
  completed
}

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({super.key, required this.secondStatus,required this.thirdStatus, required this.textFirst, required this.textSecond, required this.textThird, required this.firstStatus});

  final ProgressStatus secondStatus;
  final ProgressStatus firstStatus;
  final ProgressStatus thirdStatus;
  final String textFirst;
  final String textSecond;
  final String textThird;

  getInCompleteWiget(String progress, ProgressStatus status ) {
    if (status == ProgressStatus.incomplete) {
      return Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5)
        ),
        child: Center(
          child: Text(progress,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14, // light
                 color: AppColors.grayshade), textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (status == ProgressStatus.inProgress) {
      return Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5),
            border: Border.all(color: AppColors.brownColor)
        ),
        child: Center(
          child: Text(progress,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14, // light
                 color: AppColors.brownColor), textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (status == ProgressStatus.completed) {
      return SizedBox(
        height: 25,
        width: 25,
        child: Image.asset(AppCommonFeatures.instance.imagesFactory.check_round, height: 25, width: 25,),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 80,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.appColorBlueLight
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: getInCompleteWiget('1', firstStatus)
              ),
              Text(textFirst, style: (firstStatus == ProgressStatus.completed||firstStatus == ProgressStatus.inProgress) ? TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14, // light
                   color: AppColors.brownColor
              ) : TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14, // light
                   color: AppColors.grayshade
              )
              ),
            ],
          ),
          Flexible(child: Image.asset(AppCommonFeatures.instance.imagesFactory.dash_iamge, width: screenWidth * 0.15)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: getInCompleteWiget('2',secondStatus)
              ),
              Text(textSecond, style: (secondStatus == ProgressStatus.completed||secondStatus == ProgressStatus.inProgress) ?  TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14, // light
                   color: AppColors.brownColor
              ) :  TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14, // light
                   color: AppColors.grayshade
              )
              ),
            ],
          ),
          Flexible(child: Image.asset(AppCommonFeatures.instance.imagesFactory.dash_iamge, width: screenWidth * 0.15)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: getInCompleteWiget('3', thirdStatus)
              ),
              Text(textThird, style: (thirdStatus == ProgressStatus.completed||thirdStatus == ProgressStatus.inProgress)  ?  TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14, // light
                   color: AppColors.brownColor
              ) :  TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14, // light
                   color: AppColors.grayshade
              )
              ),
            ],
          ),
        ],
      ),
    );
  }
}




class ProgressCartWidget extends StatelessWidget {
  const ProgressCartWidget({Key? key, required this.secondStatus,required this.thirdStatus, required this.textFirst, required this.textSecond, required this.textThird, required this.firstStatus}) : super(key: key);

  final ProgressStatus secondStatus;
  final ProgressStatus firstStatus;
  final ProgressStatus thirdStatus;
  final String textFirst;
  final String textSecond;
  final String textThird;

  getInCompleteWiget(String progress, ProgressStatus status ) {
    if (status == ProgressStatus.incomplete) {
      return Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5)
        ),
        child: Center(
          child: Text(progress,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14, // light
                 color: AppColors.grayshade), textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (status == ProgressStatus.inProgress) {
      return Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5),
            border: Border.all(color: AppColors.brownColor)
        ),
        child: Center(
          child: Text(progress,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14, // light
                 color: AppColors.brownColor), textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (status == ProgressStatus.completed) {
      return SizedBox(
        height: 25,
        width: 25,
        child: Image.asset(AppCommonFeatures.instance.imagesFactory.check_round, height: 25, width: 25,),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 55,
      width: screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.lightblueshade
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: getInCompleteWiget('1',firstStatus)
              ),
              Text(textFirst, style: (firstStatus == ProgressStatus.completed) ? TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14, // light
                   color:AppColors.brownColor
              ) : TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14, // light
                   color: (firstStatus == ProgressStatus.inProgress) ?  AppColors.brownColor : AppColors.grayshade
              )
              ),
            ],
          ),
          Flexible(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Image.asset(AppCommonFeatures.instance.imagesFactory.dash_iamge, width: screenWidth * 0.35,height: 1,),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: getInCompleteWiget('2',secondStatus)
              ),
              Text(textSecond, style: (secondStatus == ProgressStatus.completed) ? TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14, // light
                   color: AppColors.brownColor
              ) : TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14, // light
                   color: (secondStatus == ProgressStatus.inProgress) ?  AppColors.brownColor : AppColors.grayshade
              )
              ),
            ],
          ),
          Flexible(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Image.asset(AppCommonFeatures.instance.imagesFactory.dash_iamge, width: screenWidth * 0.35),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: getInCompleteWiget('3',thirdStatus)
              ),
              Text(textThird, style: (thirdStatus == ProgressStatus.completed)  ? TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14, // light
                   color: AppColors.brownColor
              ) :  TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14, // light
                   color: (thirdStatus == ProgressStatus.inProgress) ?  AppColors.brownColor : AppColors.grayshade
              )
              ),
            ],
          ),
        ],
      ),
    );
  }
}

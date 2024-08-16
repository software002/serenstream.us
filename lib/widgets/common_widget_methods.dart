import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../Constants/assets.dart';
import '../Constants/colors.dart';

abstract class CommonWidgetMethods extends Widget {
  const CommonWidgetMethods({super.key});

  static void resultDialogBox(
      BuildContext context, String title, String lottie) {
    AlertDialog dialog = AlertDialog(
      icon: Lottie.asset(lottie),
      title: Center(
          child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      )),
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  static Widget amountWidget(
      {required String amount,
      required double fontSize,
      required double iconSize,
      double? textWidth,
      double? textHeight,
      BoxFit? fit,
      Color? textColor}) {
    return SizedBox(
      width: textWidth ?? 50.dm,
      height: textHeight ?? 20.dm,
      child: FittedBox(
        fit: fit ?? BoxFit.contain,
        child: Row(children: [
          SvgPicture.asset(
            Assets.svgRupeeLogo,
            height: iconSize,
            width: 10.dm,
          ),
          Text(
            amount,
            style: TextStyle(
              color: textColor ?? AppColors.whiteshade,
              fontWeight: FontWeight.w700,
              fontSize: 15.dm,
            ),
          ),
        ]),
      ),
    );
  }

  static Widget mainPanelBox({
    required String title,
    required double titleFontSize,
    required double height,
    required String amount,
    required double fontSize,
    required double iconSize,
    required double textWidth,
    required double textHeight,
    required BoxFit fit,
  }) {
    return Card(
      color: AppColors.black,
      child: Container(
        margin: EdgeInsets.only(top: 15.dm, left: 30.dm, right: 20.dm),
        width: 280.dm,
        height: 100.dm,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: AppColors.whiteshade,
                    fontWeight: FontWeight.w700,
                    fontSize: titleFontSize),
              ),
              SizedBox(
                height: 8.dm,
              ),
              amountWidget(
                  amount: amount,
                  fontSize: fontSize,
                  iconSize: iconSize,
                  textWidth: textWidth,
                  textHeight: textHeight,
                  fit: fit),
            ],
          ),
        ),
      ),
    );
  }

  // Putting commas inbetween amount based on number-system
  static String getFormattedNumber(String value) {
    NumberFormat numberFormat = NumberFormat.decimalPattern();
    String number = numberFormat.format(double.parse(value.toString()));
    return number;
  }

  static Widget uploadInvoiceWidget(
      BuildContext context, String svgAsset, String title, Function() onClick) {
    return GestureDetector(
      onTap: onClick(),
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.dm, horizontal: 20.dm),
        height: 120.dm,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(16.dm))),
        padding: EdgeInsets.symmetric(
          vertical: 8.dm,
          horizontal: 8.dm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svgAccountIcon,
              height: 50.dm,
              width: 50.dm,
            ),
            FittedBox(
              child: SizedBox(
                width: 100.dm,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static void showPopupDialog(String message,String title,String yes,String no,BuildContext context, Function() onPositiveButtonPressed, Function() onNegativeButtonPressed){
    Dialog popupDia=Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child:  Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 20,
              top: 45,
              right: 20,
              bottom: 20,
            ),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 20)
                        ),
                      onPressed: onPositiveButtonPressed,
                      child: Text(
                        yes,
                        style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold),

                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 20)
                          ),
                      onPressed: onNegativeButtonPressed,
                      child: Text(
                        no,
                        style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
         /* Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
    showDialog(context: context,  builder: (context) => popupDia,);

  }
}




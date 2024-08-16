// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget(
      {required this.title,
      required this.backgroundColor,
      required this.txtColor,
      required this.onClick,
      required this.horizontalMargin,
      required this.verticalMargin,
      this.fontSize});
  String title;
  Color backgroundColor, txtColor;
  double verticalMargin, horizontalMargin;
  double? fontSize;
  Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(strokeAlign: 1)),
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: verticalMargin, horizontal: horizontalMargin),
          child: Text(
            title,
            style: TextStyle(color: txtColor, fontSize: fontSize ?? 15.dm),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}

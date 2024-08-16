import 'package:flutter/material.dart';
import 'package:serenestream/Constants/AppSizer.dart';
import '../Constants/colors.dart';
import '../Constants/font_family.dart';
import 'nuts_indicator.dart';


class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final double? borderRadius;
  final double? height;
  final double? elevation;
  final EdgeInsets? padding;
  final double? loaderSize;
  final FontWeight? fontWeight;
  final Color? loaderColor;
  final double? fontSize;
  final Color? fontColor;
  final bool disabled;
  final bool fullWidth;
  final String? icon;

  const CustomButton({
    required this.label,
    required this.onPressed,
    this.fullWidth =true,
    super.key,
    this.isLoading = false,
    this.color,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.disabled = false,
    this.loaderSize,
    this.loaderColor,
    this.padding, this.height, this.elevation, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //temp onPressed: disabled ? null : isLoading ? () {} : onPressed,
      onPressed:  onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        padding: padding,
        disabledBackgroundColor: AppColors.grayshade,
        backgroundColor: color ?? AppColors.buttonColor,
        minimumSize: Size(fullWidth?double.infinity:0, height ?? 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: (icon != null) ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(icon ?? '',
                height: 18,
                width: 18,
              ),
            ),
          ),
          isLoading
              ? SizedBox(
            height: loaderSize,
            width: loaderSize,
            child: Row(
              children: [

                SizedBox(
                  width: 24,
                  height: 24,
                  child:NutsActivityIndicator(
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                    tickCount: 24,
                    relativeWidth: 0.4,
                    radius: 10,
                    startRatio: 0.7,
                    animationDuration: Duration(milliseconds: 1000),
                  ),

                ),
                SizedBox(width: AppSizer.sixteen,),

                Text(
                  label,
                  style: TextStyle(
                    color: fontColor ?? Colors.white,
                    fontSize: fontSize ?? 16,
                    
                    fontWeight: fontWeight ?? FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
              : Text(
            label,
            style: TextStyle(
              color: fontColor ?? Colors.white,
              fontSize: fontSize ?? 16,
              
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          ),
        ],
      )

    );
  }
}

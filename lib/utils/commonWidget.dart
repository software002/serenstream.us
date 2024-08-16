import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serenestream/Constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:serenestream/home/dashboard_screen.dart';
import 'package:serenestream/meditation/breathe_out_screen.dart';
import 'package:serenestream/meditation/hold_screen.dart';
import 'package:serenestream/utils/util_klass.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constants/AppSizer.dart';
import '../Constants/font_family.dart';

import '../home/controller/PressedImage.dart';
import 'AppCommonFeatures.dart';
import 'custom_circle_timer/CircularCountDownTimerr.dart';

typedef void ToggleCallback(bool isObscure);

class CommonWidget {
  static final CommonWidget _commonWidget = CommonWidget._internal();
  // late CaseloadListCubit caseloadListCubit;
  late String caseLoadId = "";

  int itemIndex = -1;
  bool isCaseStarted = false;

  factory CommonWidget() {
    return _commonWidget;
  }

  CommonWidget._internal();

  getAppBar(BuildContext context, String title,
      {String? addText, VoidCallback? voidCallback}) {
    return AppBar(
      title: Transform(
        transform: Matrix4.translationValues(0, 0, 0),
        child: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white)),
      ),
      backgroundColor: AppColors.deepblue,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,
      actions: addText == "+Add"
          ? [
              Padding(
                  padding: const EdgeInsets.only(right: AppSizer.twenteey),
                  child: GestureDetector(
                    child: Text(addText ?? "",
                        style: const TextStyle(
                            color: Colors.white, fontSize: AppSizer.sixteen)),
                    onTap: () {
                      voidCallback!.call();
                    },
                  )),
            ]
          : [],
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget countDownTimer(BuildContext context,CountDownControllerr ctrl,int duration_value,type,totalTime){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CircularCountDownTimerr(
        duration: duration_value,
        initialDuration:1,
        controller: ctrl,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 3,
        ringColor: Colors.white,
        ringGradient: null,
        fillColor: AppColors.pinkColor,
        fillGradient: null,
        backgroundColor: AppColors.pinkColor,
        backgroundGradient: null,
        strokeWidth: 13.0,
        strokeCap: StrokeCap.round,
        textStyle: TextStyle(
            fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.HH_MM_SS,
        isReverse: false,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: false,
        onStart: () {
          debugPrint('Countdown Started');
        },
        onComplete: () {
          debugPrint('Countdown Ended');
        },
        onChange: (String timeStamp) {
          debugPrint('Countdown Changed $timeStamp');
        },

        timeFormatterFunction: (defaultFormatterFunction, duration) {
          return Function.apply(defaultFormatterFunction, [duration]);
        },
         /*   onStart: () {
          debugPrint('Countdown Started');
        },
        onComplete: () {
          debugPrint('Countdown Ended');
          if(type=="breathein"){
            UtilKlass.navigateScreenOff(HoldScreen(timer_value: totalTime));
          }else if(type=="hold"){
            UtilKlass.navigateScreen(BreatheOutScreen(timer_value: totalTime));
          }else if(type=="breatheout"){
            UtilKlass.navigateScreen(DashboardScreen());
          }
        },
        onChange: (String timeStamp) {
          debugPrint('Countdown Changed $timeStamp');
        },
        timeFormatterFunction: (defaultFormatterFunction, duration) {
          debugPrint('Countdown **** $duration');
          if (duration.inSeconds == 0) {
            return "Start";
          } else {
            return Function.apply(defaultFormatterFunction, [duration]);
          }
        },*/
      ),
    );
  }
  Widget title(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.titleColor,
            fontSize: AppSizer.thirty,
            
            fontWeight: FontWeight.w600));
  }
  Widget title_breath(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.black,
            fontSize: AppSizer.thirty,

            fontWeight: FontWeight.w600));
  }

  Widget normalTitle(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.normalTextColor,
            fontSize: AppSizer.fourteen,
            
            fontWeight: FontWeight.w400));
  }

  Widget dashTitle(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.titleColor,
            fontSize: AppSizer.fifteen,
            fontWeight: FontWeight.w600));
  }

  Widget titleMultiColor(
      String firstTitle, String secondTitle, double fontSize, Function() func) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: firstTitle,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize,
                    
                    color: AppColors.black)),
            WidgetSpan(
              child: SizedBox(width: 8),
            ),
            TextSpan(
              text: secondTitle,
              recognizer: TapGestureRecognizer()..onTap = func,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppSizer.fourteen,
                  
                  color: AppColors.titleColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget simpleText_body_text_color(String title, {TextAlign? txtAlign}) {
    return Text(title,
        style: TextStyle(
            color: AppColors.grayshade,
            
            fontSize: AppSizer.fourteen),
        textAlign: txtAlign ?? TextAlign.center);
  }

  Widget textfield(
      String hintText, TextEditingController controller, bool isObscureText,
      {TextInputType keyboardType = TextInputType.text,
      bool isEnable = true,
      String leftIcon = '',
      bool readyOnly = false,
      bool showCursor = true,
      String rightIcon = '',
      Color? txtColor}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscureText,
      cursorColor: Colors.black,
      readOnly: readyOnly,
      showCursor: showCursor,
      enabled: isEnable,
      style: TextStyle(color: txtColor ?? AppColors.black),
      decoration: InputDecoration(
        filled: false,
        prefixIcon: (leftIcon != '')
            ? Image.asset(leftIcon,
                height: AppSizer.twenteeyFour, width: AppSizer.twenteeyFour)
            : null,
        suffixIcon: (rightIcon != '')
            ? Image.asset(rightIcon,
                height: AppSizer.twenteeyFour, width: AppSizer.twenteeyFour)
            : null,
        prefixIconConstraints: const BoxConstraints(
            minHeight: AppSizer.twenteeyFour, minWidth: AppSizer.fifty),
        suffixIconConstraints: const BoxConstraints(
            minHeight: AppSizer.twenteeyFour, minWidth: AppSizer.fifty),
        fillColor: AppColors.appColor,
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.grayshade),
            borderRadius: BorderRadius.circular(AppSizer.eight)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grayshade),
            borderRadius: BorderRadius.circular(AppSizer.eight)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.titleColor),
            borderRadius: BorderRadius.circular(AppSizer.eight)),
        contentPadding: const EdgeInsets.all(AppSizer.fifteen),
        hintStyle: const TextStyle(
            color: AppColors.softGrey,
            fontSize: AppSizer.fourteen,
            fontWeight: FontWeight.w400),
        hintText: hintText,
      ),
    );
  }

  Widget passwordTextFieldWithToggle(
      {required String hintText,
      required TextEditingController controller,
      bool isObscureText = true,
      TextInputType keyboardType = TextInputType.text,
      required ToggleCallback onToggle}) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        prefixIconConstraints: const BoxConstraints(
            minHeight: AppSizer.twenteeyFour, minWidth: AppSizer.fifty),
        fillColor: Colors.white,
        hintText: hintText,
        suffixIconConstraints: const BoxConstraints(
            minHeight: AppSizer.thirty, minWidth: AppSizer.fifty),
        hintStyle: const TextStyle(
            color: AppColors.softGrey, fontSize: AppSizer.fourteen),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grayshade),
            borderRadius: BorderRadius.circular(AppSizer.eight)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.titleColor),
            borderRadius: BorderRadius.circular(AppSizer.eight)),
        contentPadding: const EdgeInsets.all(AppSizer.fifteen),
        suffixIcon: GestureDetector(
          onTap: () {
            // Toggle the obscure text mode
            isObscureText = !isObscureText;
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
            // Call the callback function
            onToggle(isObscureText);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Image(
              image: isObscureText
                  ? AssetImage(
                      AppCommonFeatures.instance.imagesFactory.eyesClose)
                  : AssetImage(
                      AppCommonFeatures.instance.imagesFactory.eyesClose),
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget pinkButton( VoidCallback callback, String label) {
    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: Padding(
        padding: const EdgeInsets.only(left: 50,right: 50,bottom: 20),
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
            callback.call();
          },
          child: Text( label=="Pause" ? "| |  $label" : "$label",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizer.fourteen)),
        ),
      ),
    );
  }

  Widget button(String buttonName, VoidCallback callback) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepblue,
          foregroundColor: AppColors.deepblue,
          shadowColor: AppColors.deepblue,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizer.ten)),
        ),
        onPressed: () {
          callback.call();
        },
        child: Text(buttonName,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: AppSizer.fourteen)),
      ),
    );
  }

  Widget wrapButton(String buttonName, VoidCallback callback) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepblue,
        foregroundColor: AppColors.deepblue,
        shadowColor: AppColors.deepblue,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizer.twenteey)),
      ),
      onPressed: () {
        callback.call();
      },
      child: Text(buttonName,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: AppSizer.fourteen)),
    );
  }

  selectDate(BuildContext context, bool isSimpleDate,
      {DateTime? dateTime}) async {
    var finalDate = '';
    var isoFormateSelectedDate = '';
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: dateTime ?? DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.deepblue,
              onPrimary: AppColors.appColor,
              onSurface: AppColors.appColorBlueLight,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.appColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null) {
      finalDate = '';
    } else {
      finalDate = DateFormat('yyyy-MM-dd').format(picked);

      isoFormateSelectedDate =
          DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(picked);
    }
    if (isSimpleDate) {
      return finalDate;
    } else {
      return isoFormateSelectedDate;
    }
  }

  getFormateDate(String date) {
    String formateDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(DateTime.parse(date));
    String simpleeDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(formateDate));
    return simpleeDate;
  }

  Widget blankData(String title, String subtitle, String image,
      String buttonName, VoidCallback? callback) {
    return Container(
      height: 400,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizer.ten),
        color: AppColors.appColorGreen,
      ),
      margin: const EdgeInsets.only(
          left: AppSizer.fourty,
          right: AppSizer.fourty,
          top: AppSizer.sixty,
          bottom: AppSizer.sixty),
      padding: const EdgeInsets.all(AppSizer.twenteey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: AppSizer.fifty,
            child: Image.asset(image,
                height: AppSizer.fifty, width: AppSizer.fifty),
          ),
          const SizedBox(
            height: AppSizer.twenteey,
          ),
          Text(title,
              style: const TextStyle(
                  fontSize: AppSizer.sixteen,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(
            height: AppSizer.ten,
          ),
          Text(subtitle,
              style: const TextStyle(
                  fontSize: AppSizer.tweleve, color: AppColors.grayshade),
              textAlign: TextAlign.center),
          const SizedBox(
            height: AppSizer.twenteey,
          ),
          if (callback != null) wrapButton(buttonName, callback)
        ],
      ),
    );
  }
  Widget cardAndIcon(
      final VoidCallback? onPressed,
      final bool isSelected,
      final double? height,
      final double? width,
      final double? space,
      final double? fontSize,
      final String? icon,
      final double? iconWidth,
      final double? iconHeight,
      final String? label,
      ) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizer.ten),
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColors.white,
                  ),
                  child: GestureDetector(
                    onTap: onPressed,
                    child: Center(
                      child: Image.asset(
                        icon ?? '',
                        height: iconHeight,
                        width: iconWidth,
                        fit: BoxFit.contain, // Adjust to BoxFit.contain to ensure no clipping
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: space ?? AppSizer.fifteen),
          Text(
            label ?? "Test",
            style: TextStyle(
              color: AppColors.black,
              fontSize: fontSize ?? 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardWithIcon(
      final VoidCallback? onPressed,
      final bool isSelected,
      final double? height,
      final double? width,
      final double? space,
      final double? fontSize,
      final String? icon,
      final double? icon_w,
      final double? icon_h,
      final String? label) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppColors.disableBoxcolor,
            backgroundColor:
                isSelected ? AppColors.titleColor : AppColors.disableBoxcolor,
            minimumSize: Size(width ?? 200, height ?? 200),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isSelected
              ? Padding(
                  padding: const EdgeInsets.all(AppSizer.sixteen),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSizer.fifteen,
                      ),
                      Image.asset(
                        icon ?? '',
                        height: icon_h,
                        width: icon_w,
                      ),
                      SizedBox(
                        height: space ?? AppSizer.fourty,
                      ),
                      Text(
                        label ?? "Test",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize ?? 16,
                          
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(AppSizer.sixteen),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSizer.fifteen,
                      ),
                      Image.asset(
                        icon ?? '',
                        height: icon_h,
                        width: icon_w,
                      ),
                      SizedBox(
                        height: space ?? AppSizer.fourty,
                      ),
                      Text(
                        label ?? "Test",
                        style: TextStyle(
                          color: AppColors.disableTextcolor,
                          fontSize: fontSize ?? 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }

  Widget cardWithText(
      final VoidCallback? onPressed,
      final double? height,
      final double? width,
      final double? fontSize,
      final String? label) {
    return SizedBox(
      width: width ?? 80,
      height: height ?? 80,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppColors.disableBoxcolor,
            backgroundColor:AppColors.titleColor,
            minimumSize: Size(width ?? 80, height ?? 80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Center(
                child: Text(
                  label ?? "Test",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize ?? 28,
                    
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )

    ),);
  }
}

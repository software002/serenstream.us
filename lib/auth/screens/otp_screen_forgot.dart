import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:serenestream/auth/screens/forget_password.dart';
import 'package:serenestream/auth/screens/reset_password.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../Constants/AppSizer.dart';
import '../../Constants/colors.dart';
import '../../Constants/strings.dart';
import '../../common_widgets/custom_button.dart';
import '../../intro/select_gender_screen.dart';
import '../../switcher_plus/animated_switcher_translation.dart';
import '../../utils/commonWidget.dart';
import '../../utils/storage_service.dart';
import '../../utils/util_klass.dart';
import '../controller/auth_util.dart';


class OtpScreenForgot extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPassword;

  const OtpScreenForgot(
      {super.key,
      required this.userName,
      required this.userEmail,
      required this.userPassword});

  @override
  State<OtpScreenForgot> createState() => _OtpScreenForgotState();
}

class _OtpScreenForgotState extends State<OtpScreenForgot>
    with AutomaticKeepAliveClientMixin {
  final CommonWidget commonWidget = CommonWidget();
  var authHandler = new AuthUtil();

  var showTimer = true.obs;
  var defaultDuration = const Duration(seconds: 30);
  var defaultPadding = EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h);
  final _otpController = TextEditingController();
  final focusNode = FocusNode();
  var isApiCalling = false.obs;

  @override
  void dispose() {
    _otpController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 50.w,
        height: 50.w,
        margin: EdgeInsets.all(2.w),
        textStyle: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: Colors.black),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: Colors.transparent),
        ));

    return WillPopScope(
      onWillPop: () async {
        // Do something here
        UtilKlass.hideProgressAppLoading();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
       appBar: AppBar(
        backgroundColor: AppColors.white,
        leading:    IconButton(
          iconSize: 24,
          icon: GestureDetector(
            onTap: ()=>UtilKlass.hideProgressAppLoading(),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
          // the method which is called
          // when button is pressed
          onPressed: () {
       UtilKlass.navigateScreenOff(ForgetPasswordScreen());
          },
        ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0.w, 20.w, 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSizer.twenteey,),
                commonWidget.title(Strings.enterOtp),
                SizedBox(height: AppSizer.sixteen,),
                commonWidget.normalTitle(Strings.enterCodeMsg),
                SizedBox(height: AppSizer.thirty,),

                Pinput(
                  length: 6,
                  controller: _otpController,
                  focusNode: focusNode,
                  keyboardType: TextInputType.number,
                  closeKeyboardWhenCompleted: true,
                  onCompleted: (str) {
                    if (!isApiCalling.value) {

                    }
                  },
                  separatorBuilder: (index) => Container(
                    width: 1.w,
                    color: Colors.white,
                  ),
                  defaultPinTheme: defaultPinTheme,
                  showCursor: true,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    height: 55.w,
                    width: 55.w,
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSizer.fifty,
                ),
                CustomButton(
                  label: Strings.strVerify,
                  isLoading:false,
                  onPressed: () async {
                    //   AppCommonFeatures.instance.contextInit(context);
                    if(_otpController.text=="123456"){
                      UtilKlass.navigateScreenOff(ResetPasswordScreen());
                    }else{
                      UtilKlass.showToastMsg(context, "Please Enter Correct OTP");
                    }
                   // UtilKlass.navigateScreen(ResetPasswordScreen());
                  },
                ),
                const SizedBox(
                  height: AppSizer.sixteen,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: commonWidget.titleMultiColor(Strings.didNotReceiveOtp, Strings.resendOtp,AppSizer.fourteen, () => {
                  AnimatedSwitcherTranslation.top(
                  duration: const Duration(milliseconds: 0),
                  child: showTimer.value
                  ? _getCountDownUI()
                      : _getResendOTPView(),
                  )
                  }),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getResendOTPView() {
    return SizedBox(
      width: 150.w,
      height: 40.h,
      child: TextButton(
        onPressed: () {
          showTimer.value = true;
        //  _resentOtpClicked();
        },
        child: Text(
          Strings.resendOtp,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: AppColors.brownColor),
        ),
      ),
    );
  }

  Widget _getCountDownUI() {
    return SizedBox(
      width: 150.w,
      height: 40.h,
      child: SlideCountdown(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        duration: defaultDuration,
        padding: defaultPadding,
        separatorType: SeparatorType.title,
        separatorStyle: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.green),
        style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.green),
        slideDirection: SlideDirection.down,
        onDone: () {
          showTimer.value = false;
        },
        icon: Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: Icon(
            Icons.alarm,
            color: Colors.green,
            size: 18.w,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

 void addDataInFirestore(var user){
   FirebaseFirestore.instance
       .collection('users').doc(user["email"]).set(user)
       .then((value) => {
     UtilKlass.hideProgressAppLoading(),

     StorageService.saveData(StorageKeys.isLogin.toString(), true),
     StorageService.saveData(StorageKeys.emailId.toString(), user["email"]),
     UtilKlass.saveUserData(),

     UtilKlass.navigateScreen(SelectGenderScreen())
   });

   /*FirebaseFirestore.instance
       .collection('users').
   add(user).then((DocumentReference doc) =>{
     UtilKlass.hideProgressAppLoading(),
     StorageService.saveData(StorageKeys.isLogin.toString(), true),
     StorageService.saveData(StorageKeys.emailId.toString(), user["email"]),
   UtilKlass.navigateScreen(SelectGenderScreen())

   });*/


 }

}

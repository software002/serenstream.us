import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:serenestream/auth/screens/forget_password.dart';
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


class OtpScreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPassword;
  final int userOtpTime;

  const OtpScreen(
      {super.key,
      required this.userName,
      required this.userEmail,
      required this.userPassword, required this.userOtpTime});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
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
                    if(_otpController.text.isNotEmpty){
                      UtilKlass.showProgressAppLoading(context);
                      Future<bool> otpExist = UtilKlass.otpExists(widget.userEmail, _otpController.text, DateTime.now().millisecondsSinceEpoch);
                      if(await otpExist){
                        Future<bool> otpValid = UtilKlass.otpValid(widget.userEmail, _otpController.text, DateTime.now().millisecondsSinceEpoch);
                        if(await otpValid){
                          Future<bool> otpNotExpire = UtilKlass.otpNotExpire(widget.userEmail, _otpController.text, widget.userOtpTime);
                          if(await otpNotExpire){
                            UtilKlass.showToastMsg(context, "Success OTP");
                            authHandler.handleSignUp(widget.userEmail, widget.userPassword)
                                .then((String uId) {
                              print("user success $uId");
                              if(uId!="Invalid"){
                                var user = <String, dynamic>{
                                  "userId": uId,
                                  "email": widget.userEmail,
                                  "name": widget.userName,
                                  "otp":_otpController.text,
                                  "createdDate":DateTime.now().millisecondsSinceEpoch
                                };
                                addDataInFirestore(user);
                              }

                            }).catchError((e) => print(e));

                          }else{
                            UtilKlass.hideProgressAppLoading();
                            UtilKlass.showToastMsg(context, " OTP Expired");
                          }
                        }else{
                          UtilKlass.hideProgressAppLoading();
                          UtilKlass.showToastMsg(context, " OTP Wrong");
                        }
                      }else{
                        UtilKlass.hideProgressAppLoading();
                        UtilKlass.showToastMsg(context, " OTP Invalid");
                      }
                      //for create user in auth

                    }else{
                      UtilKlass.hideProgressAppLoading();
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
                  setState(() {
                    _otpController.text="";
                  }),
                    sendOtpEmail(widget.userEmail),
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

/*   FirebaseFirestore.instance
       .collection('users').
   add(user).then((DocumentReference doc) =>{
     UtilKlass.hideProgressAppLoading(),
     StorageService.saveData(StorageKeys.isLogin.toString(), true),
     StorageService.saveData(StorageKeys.emailId.toString(), user["email"]),
   UtilKlass.navigateScreen(SelectGenderScreen())

   });*/


 }

  void addOtpDataInFirestore(var user){

    UtilKlass.showProgressAppLoading(context);
    FirebaseFirestore.instance
        .collection('otp').doc(user["otpValue"].toString()).set(user)
        .then((value) => {
      UtilKlass.hideProgressAppLoading(),
      UtilKlass.showToastMsg(context, "Otp Sent Succesfully")
    });

  }
  Future<void> sendOtpEmail(String recipientEmail) async {
    UtilKlass.showProgressAppLoading(context);
    int otp=0;
    otp=UtilKlass.generateOTPNumber();

    try {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendEmail');
      final result = await callable.call(<String, dynamic>{
        'email': recipientEmail,
        'otp':otp.toString(),
      });
      if (result.data['success']) {
        UtilKlass.hideProgressAppLoading();

        var userOtp = <String, dynamic>{
          "email": recipientEmail,
          "otpValue": otp.toString(),
          "createdDate": DateTime
              .now()
              .millisecondsSinceEpoch
        };
        addOtpDataInFirestore(userOtp);
        print('Email sent: ${result.data['response']}');      } else {
        print('Error: ${result.data['error']}');
      }
    } catch (e) {
      print('Failed to send email: $e');
    }
  }
}

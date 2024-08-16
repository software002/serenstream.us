import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:serenestream/Constants/AppSizer.dart';
import 'package:serenestream/Constants/colors.dart';
import 'package:serenestream/auth/screens/register_screen.dart';
import 'package:serenestream/common_widgets/custom_button.dart';
import 'package:serenestream/home/dashboard_screen.dart';
import 'package:serenestream/utils/AppCommonFeatures.dart';

import '../../utils/storage_service.dart';
import '../Constants/assets.dart';
import '../Constants/font_family.dart';
import '../Constants/strings.dart';
import '../auth/screens/login_screen.dart';
import '../utils/util_klass.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    StorageService.saveData(StorageKeys.isMorningQuizDone.toString(), false);
    StorageService.saveData(StorageKeys.isNightQuizDone.toString(), false);
    StorageService.saveData(StorageKeys.isNoonQuizDone.toString(), false);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {

      Strings.appversion = packageInfo.version;
      Strings.buildNumber = packageInfo.buildNumber;
    });

    //_startSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashColor,
      body: _getScaffoldBody(),
    );
  }

  void _startSplash() {
    Timer(const Duration(seconds: 3), () => _openToNextScreen());
  }

  _openToNextScreen() {
    UtilKlass.navigateScreenOffAll(const RegisterScreen());

  }

  _getScaffoldBody() {
    return Center(

      child:Stack(
        children: [
          Image(image:AssetImage(AppCommonFeatures.instance.imagesFactory.splash_icon),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,),
   Column(
     children: [
       SizedBox(height: MediaQuery.of(context).size.height*0.54,),
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 25),
         child: Text(
             "${Strings.splashText}",textAlign: TextAlign.center,
             style:  TextStyle(
                 color: AppColors.dullWhite,
                 fontSize: AppSizer.sixteen,

                 fontWeight: FontWeight.w400)
         ),
       ),
       SizedBox(height: AppSizer.thirtyfive),
       Padding(
         padding: const EdgeInsets.only(left: 60,right: 60),
         child: CustomButton(color:AppColors.getstartBtnColor,label: Strings.getStarted, onPressed: (){

           var isLogin = StorageService.getData(StorageKeys.isLogin.toString(),false);

           if(isLogin){
             UtilKlass.navigateScreenOffAll(DashboardScreen());
           }
           else{
             UtilKlass.navigateScreenOffAll(LoginScreen());
           }


         },fontColor: Colors.black,),
       )

     ],
   ),

        ],
      ),
    );
  }

 /* bool isLoggedIn() {
    if (StorageKeys.userApiToken.toString().isNotEmpty ||
        StorageKeys.userApiToken.toString() != "") {
      return true;
    } else {
      return false;
    }
  }*/
}

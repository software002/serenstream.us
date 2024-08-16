import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serenestream/Constants/colors.dart';
import 'package:serenestream/auth/screens/login_screen.dart';
import 'package:serenestream/auth/screens/otp_screen.dart';
import 'package:serenestream/bloc/login/login_cubit.dart';
import 'package:serenestream/intro/select_gender_screen.dart';
import 'package:serenestream/splash/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/AppSizer.dart';
import '../../Constants/strings.dart';
import '../../common_widgets/custom_button.dart';
import '../../services/navigator_service.dart';
import '../../utils/AppCommonFeatures.dart';
import '../../utils/commonWidget.dart';
import '../../utils/util_klass.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final CommonWidget commonWidget = CommonWidget();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  bool value=false;
  late Map<String, dynamic> map;
  bool passwordIsObsecure = true;
  LoginCubit loginCubit=new LoginCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

  }

  init() async {
  //  AppCommonFeatures.instance.contextInit(context);
    map = Map();
  }

  @override
  void dispose() {
    emailController.dispose();
    password_controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        NavigationService.removeKeyboard();
      },
      child: WillPopScope(
        onWillPop: () async {
          // Do something here
          UtilKlass.hideProgressAppLoading();
          return false;
        },
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
            leading: IconButton(
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
                UtilKlass.navigateScreenOff(SplashScreen());

              },
            ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizer.twenteey),
                child: BlocProvider(
                    create: (_) => loginCubit,
                    child: BlocListener<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginStateLoaded) {

                        } else if (state is UpdateLoginPasswordVisibilityState) {
                          passwordIsObsecure = state.isObsecure;
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizer.twenteey),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: AppSizer.twenteey,),
                            commonWidget.title(Strings.signUp),
                            SizedBox(height: AppSizer.sixteen,),
                            commonWidget.normalTitle(Strings.temp),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: AppSizer.sixteen,
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      UtilKlass.showToastMsg(context, "Google1");

                                      UtilKlass.showProgressAppLoading(context);

                                      User? data = await UtilKlass.signInWithGoogle(context: context);
                                      if(data!=null){
                                        UtilKlass.showToastMsg(context, "Google2");
                                        var user = <String, dynamic>{
                                          "userId": data?.uid,
                                          "email": data?.email,
                                          "name": data?.displayName,
                                          "otp":"123456",
                                          "createdDate":DateTime.now().millisecondsSinceEpoch
                                        };
                                        var usersRef =await FirebaseFirestore.instance.collection('users').doc(data?.email);

                                        usersRef.get()
                                            .then((docSnapshot) =>
                                        {
                                          if (docSnapshot.exists) {
                                            UtilKlass.hideProgressAppLoading(),
                                            UtilKlass.showToastMsg(context, "User Already Registered")
                                          }else{
                                            UtilKlass.showToastMsg(context, "Google3"),
                                           // UtilKlass.hideProgressAppLoading(),
                                      UtilKlass.addDataInFirestore(user,SelectGenderScreen()),
                                          }
                                        });
                                      }else{
                                        UtilKlass.showToastMsg(context, "Google4");
                                      }
                                      /*  print(data?.displayName);
                                    print(data?.email);
                                    print(data?.uid);*/
                                    },
                                    child: Center(child: Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.google),height: 24.h,))),
                                const SizedBox(
                                  height: AppSizer.sixteen,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          height: 0.5,
                                          color: AppColors.lineColor,
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppSizer.ten, right: AppSizer.ten),
                                        child: Text(
                                          '${Strings.or}',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: AppSizer.fourteen,

                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        )),


                                    Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          height: 0.5,
                                          color: AppColors.lineColor,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSizer.sixteen,
                                ),
                                commonWidget.textfield(
                                    Strings.hintName,
                                    nameController,
                                    false,
                                    keyboardType: TextInputType.emailAddress),
                                const SizedBox(
                                  height: AppSizer.sixteen,
                                ),
                                commonWidget.textfield(
                                    Strings.hintEmailPhone,
                                    emailController,
                                    false,
                                    keyboardType: TextInputType.emailAddress),
                                const SizedBox(
                                  height: AppSizer.sixteen,
                                ),

                                BlocBuilder<LoginCubit, LoginState>(
                                    builder: (context, state) {
                                      return commonWidget.passwordTextFieldWithToggle(
                                        hintText:
                                        Strings.hintPassword,
                                        controller: password_controller,
                                        isObscureText: passwordIsObsecure,
                                        onToggle: (bool isObscure) {
                                          passwordIsObsecure = isObscure;
                                          loginCubit.emit(
                                              UpdateLoginPasswordVisibilityState(
                                                  passwordIsObsecure,
                                                  "password"));
                                        },
                                      );
                                    }),
                              ],
                            ),

                            const SizedBox(
                              height: AppSizer.tweleve,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: this.value,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.value = value?? false;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:5),
                                  child: commonWidget.titleMultiColor(Strings.termAgree, Strings.termsConditions,AppSizer.tweleve, () => {launch('https://www.serenestream.us/termsOfService/')}),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 48),
                              child: commonWidget.titleMultiColor(Strings.and, Strings.privacyPolicy, AppSizer.tweleve,() => {launch('https://www.serenestream.us/privacyPolicy')}),
                            ),


                            const SizedBox(
                              height: AppSizer.thirty,
                            ),
                            CustomButton(
                              label: Strings.strCreateAccount,
                                isLoading:false,
                              onPressed: () async {
                                UtilKlass.showProgressAppLoading(context);

                               // print("time************${DateTime.now().millisecondsSinceEpoch}");
                             //   AppCommonFeatures.instance.contextInit(context);
                            //UtilKlass.generateOTPNumber();
                                var usersRef =await FirebaseFirestore.instance.collection('users').doc(emailController.text);

                                usersRef.get()
                                    .then((docSnapshot) =>
                                {
                                  if (docSnapshot.exists) {
                                UtilKlass.hideProgressAppLoading(),
                                    UtilKlass.showToastMsg(context, "User Already Registered")
                                  }else{
                                UtilKlass.hideProgressAppLoading(),
                                    sendOtpEmail(emailController.text)
                                  }
                                });
                              },
                            ),

                            const SizedBox(
                              height: AppSizer.sixteen,
                            ),
                            commonWidget.titleMultiColor(Strings.strAlreadyHaveAnAccount, Strings.signIn,AppSizer.fourteen, () =>
                            {
                            UtilKlass.navigateScreen(LoginScreen()),

                            }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(child:Text(Strings.buildNumber)),
                            ),
                            // SocialLoginWidget(loginCubit),
                          ],
                        ),
                      ),
                      //   ),
                      // ),
                    )),
              ),
            )),
      ),
    );
  }

  void addOtpDataInFirestore(var user){

    UtilKlass.showProgressAppLoading(context);
    FirebaseFirestore.instance
        .collection('otp').doc(user["otpValue"].toString()).set(user)
        .then((value) => {
      UtilKlass.hideProgressAppLoading(),
    UtilKlass.navigateScreen(OtpScreen(userName: nameController.text, userEmail: emailController.text, userPassword: password_controller.text,userOtpTime: user["createdDate"])),

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

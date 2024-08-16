import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serenestream/Constants/colors.dart';
import 'package:serenestream/auth/screens/forget_password.dart';
import 'package:serenestream/auth/screens/register_screen.dart';
import 'package:serenestream/bloc/login/login_cubit.dart';
import 'package:serenestream/home/dashboard_screen.dart';
import 'package:serenestream/intro/select_gender_screen.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../Constants/AppSizer.dart';
import '../../Constants/assets.dart';
import '../../Constants/strings.dart';
import '../../common_widgets/custom_button.dart';
import '../../services/navigator_service.dart';
import '../../utils/AppCommonFeatures.dart';
import '../../utils/commonWidget.dart';
import '../../utils/logx.dart';
import '../../utils/storage_service.dart';
import '../../utils/storage_service_apple.dart';
import '../../utils/util_klass.dart';
import '../controller/auth_util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final CommonWidget commonWidget = CommonWidget();
  var authHandler = new AuthUtil();
  var isIOS = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController password_controller = TextEditingController();
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
    if (Platform.isAndroid) {
      isIOS = false;
    } else if (Platform.isIOS) {
      isIOS = true;
    }
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
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizer.fifteen),
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
                            SizedBox(height: AppSizer.seventy,),
                            commonWidget.title(Strings.signIn),
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

                                    User? data = await UtilKlass.signInWithGoogle(context: context);
                                    if(data!=null){
                                      UtilKlass.showProgressAppLoading(context);
                                          var user = <String, dynamic>{
                                      "userId": data?.uid,
                                      "email": data?.email,
                                      "name": data?.displayName,
                                      "otp":"123456",
                                      "createdDate":DateTime.now().millisecondsSinceEpoch
                                    };
    if(data?.email!=null && data.email.toString().isNotEmpty){
      var usersRef =await FirebaseFirestore.instance.collection('users').doc(data?.email);

      usersRef.get()
          .then((docSnapshot) =>
      {
        if (docSnapshot.exists) {
          UtilKlass.hideProgressAppLoading(),
          UtilKlass.addDataInFirestore(user,DashboardScreen()),
        }else{
          UtilKlass.hideProgressAppLoading(),
          UtilKlass.addDataInFirestore(user,SelectGenderScreen()),
        }
      });
    }

                                    }
                                  /*  print(data?.displayName);
                                    print(data?.email);
                                    print(data?.uid);*/
                                  },
                                    child: Center(child: Image(image: AssetImage(AppCommonFeatures.instance.imagesFactory.google),height: 24.h,))),

                                isIOS
                                    ? SizedBox(
                                  height: 16.h,
                                )
                                    : const SizedBox(
                                  height: AppSizer.sixteen,
                                ),
                                isIOS
                                    ? Column(
                                      children: [
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
                                        InkWell(
                                        child: buildAppleButton(),
                                        onTap: () {
                                          _appleButtonPressed();
                                        }),
                                      ],
                                    )
                                    : Container(),
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
                              height: AppSizer.ten,
                            ),
                           Align(
                             alignment:Alignment.bottomRight,
                             child: GestureDetector(
                               onTap: (){
                                 UtilKlass.navigateScreen(ForgetPasswordScreen());
                               },
                               child: Text(
                                   Strings.forgetPassword,textAlign: TextAlign.center,
                                   style:  TextStyle(
                                       color: AppColors.softGrey,
                                       fontSize: AppSizer.tweleve,
            
                                       fontWeight: FontWeight.w400)
                               ),
                             ),
                           ),
                            const SizedBox(
                              height: AppSizer.thirty,
                            ),
                            CustomButton(

                              label: Strings.strLogin,
                                isLoading:false,
                              onPressed: () {
                                if(emailController.text!=""&&password_controller.text!=""){
                                  UtilKlass.showProgressAppLoading(context);
            
                                  //   AppCommonFeatures.instance.contextInit(context);
                                  authHandler.handleSignInEmail(emailController.text,password_controller.text)
                                      .then((User user) {
                                    print("user success ${user.uid}");
                                    if(user!=null){
                                      UtilKlass.hideProgressAppLoading();
                                      StorageService.saveData(StorageKeys.isLogin.toString(), true);
                                      StorageService.saveData(StorageKeys.emailId.toString(), emailController.text);
                                      UtilKlass.saveUserData();
                                      UtilKlass.navigateScreenOffAll(DashboardScreen());
            
                                    }else{
                                      UtilKlass.hideProgressAppLoading();
                                      UtilKlass.showToastMsg(context, "Invalid User");
                                    }
            
                                  }).catchError(
            
                                          (e) => {
                                          UtilKlass.hideProgressAppLoading(),
                                        UtilKlass.showToastMsg(context, "Invalid User"),
                                        print(e)
                                      }
                                  );
            
                                }else{

                                  UtilKlass.showToastMsg(context, "Please fill corect data");
            
                              }
                                }
            
                            ),
                            const SizedBox(
                              height: AppSizer.sixteen,
                            ),
                            commonWidget.titleMultiColor(Strings.strDontHaveAnAccount, Strings.signUp, AppSizer.fourteen,() => {
                            UtilKlass.navigateScreen(RegisterScreen()),
            
                            })
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

  buildAppleButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.blackshade,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppCommonFeatures.instance.imagesFactory.Ic_apple,
                  height: 20.w,
                  width: 20.w,
                  color: AppColors.black,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "Login with Apple",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackshade),
                ),
              ],
            ),
          )),
    );
  }

  void _appleButtonPressed() {
    String completeUserDetails = "";

    String appleEmail = "";
    String appleFirstName = "";
    String appleLastName = "";


    LogX.printWaring("Apple dsignInWithApple");
    signInWithApple().then((value) => {
    // UtilKlass.showProgressAppLoading(context),
    LogX.printWaring("Apple  dinsidw signInWithApple"),
      appleEmail = StorageServiceApple.getData(
          StorageAppleKeys.appleEmail.toString(), ""),
      appleFirstName = StorageServiceApple.getData(
          StorageAppleKeys.appleFirstName.toString(), ""),
      appleLastName = StorageServiceApple.getData(
          StorageAppleKeys.appleLastName.toString(), ""),

      _callAppleLoginApi(appleEmail, appleFirstName, appleLastName)

      // completeUserDetails =
      //     "value.user?.uid - ${value?.uid}\nvalue.user?.displayName - ${value?.displayName}\nvalue.user?.email - ${value?.email}",
      // UtilKlass.navigateScreen(DeleteYaar(appleData: completeUserDetails))
    });
  }
  Future<User> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);


    // Request credential for the currently signed in Apple account.

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,

      ],
      nonce: nonce,
    );


   // UtilKlass.hideProgressAppLoading();

    if (appleCredential?.email != null) {

      StorageServiceApple.saveData(
          StorageAppleKeys.appleEmail.toString(), '${appleCredential?.email}');
    }

    if (appleCredential?.givenName != null) {

      StorageServiceApple.saveData(StorageAppleKeys.appleFirstName.toString(),
          '${appleCredential?.givenName}');
    }

    if (appleCredential?.familyName != null) {


      StorageServiceApple.saveData(StorageAppleKeys.appleLastName.toString(),
          '${appleCredential?.familyName}');
    }

    debugPrint(
        "appleCredential authorizationCode - ${appleCredential?.authorizationCode}");
    debugPrint("appleCredential email - ${appleCredential?.email}");
    debugPrint("appleCredential state - ${appleCredential?.state}");
    debugPrint("appleCredential givenName - ${appleCredential?.givenName}");
    debugPrint("appleCredential familyName - ${appleCredential?.familyName}");
    debugPrint(
        "appleCredential identityToken - ${appleCredential?.identityToken}");
    debugPrint(
        "appleCredential userIdentifier  - ${appleCredential?.userIdentifier}");

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    final userCredential =
    await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    final firebaseUser = userCredential.user!;

    final displayName =
        '${appleCredential.givenName} ${appleCredential.familyName}';

    firebaseUser?.updateDisplayName(displayName);

    firebaseUser?.updateEmail('${appleCredential?.email}');




    return firebaseUser;
  }

  _callAppleLoginApi(
      String appleEmail, String appleFirstName, String appleLastName) async {
    //UtilKlass.showProgressAppLoading(context);


    LogX.printWaring("Apple appleEmail: $appleEmail");
    LogX.printWaring("Apple appleFirstName: $appleFirstName");
    LogX.printWaring("Apple appleLastName: $appleLastName");

      var user = <String, dynamic>{
        "userId": "0",
        "email": appleEmail,
        "name":"$appleFirstName $appleLastName",
        "otp":"123456",
        "createdDate":DateTime.now().millisecondsSinceEpoch
      };

        if(appleEmail!=null && appleEmail.toString().isNotEmpty){
          var usersRef =await FirebaseFirestore.instance.collection('users').doc(appleEmail);

          usersRef.get()
              .then((docSnapshot) =>
          {
            if (docSnapshot.exists) {


              LogX.printWaring("Apple docSnapshot.exists: "),
             // UtilKlass.hideProgressAppLoading(),
              UtilKlass.addDataInFirestore(user,DashboardScreen()),
            }else{


          //    UtilKlass.hideProgressAppLoading(),
              LogX.printWaring("Apple not docSnapshot.exists: "),
              UtilKlass.addDataInFirestore(user,SelectGenderScreen()),
            }
          });
        }




/*
    var request = AppleLoginRequest(
        fcmToken: token,
        email: appleEmail,
        givenName: appleFirstName,
        familyName: appleLastName);
    if (!context.mounted) return;

    LogX.printError(jsonEncode(request));

    _apiResponse.postWebService(
        context, Endpoints.authAppleLogin, Endpoints.tagAppleLogin, request);*/
  }
  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

}

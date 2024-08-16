import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenestream/Constants/colors.dart';
import 'package:serenestream/auth/screens/login_screen.dart';
import 'package:serenestream/bloc/login/login_cubit.dart';

import '../../Constants/AppSizer.dart';
import '../../Constants/strings.dart';
import '../../common_widgets/custom_button.dart';
import '../../services/navigator_service.dart';
import '../../utils/commonWidget.dart';
import '../../utils/util_klass.dart';
import 'otp_screen.dart';
import 'otp_screen_forgot.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final CommonWidget commonWidget = CommonWidget();
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
    return GestureDetector(
      onTap: (){
        NavigationService.removeKeyboard();
      },
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
          leading:    IconButton(
            iconSize: 24,
            icon: const Icon(
              Icons.arrow_back,
            ),
            // the method which is called
            // when button is pressed
            onPressed: () {
              UtilKlass.navigateScreenOff(LoginScreen());

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
                          horizontal: AppSizer.fifteen),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: AppSizer.twenteey,),
                          commonWidget.title(Strings.strForgetPassword),
                          SizedBox(height: AppSizer.sixteen,),
                          commonWidget.normalTitle(Strings.temp),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const SizedBox(
                                height: AppSizer.sixteen,
                              ),
                              commonWidget.textfield(
                                  Strings.hintEmailPhone,
                                  emailController,
                                  false,
                                  keyboardType: TextInputType.emailAddress),


                            ],
                          ),


                          const SizedBox(
                            height: AppSizer.thirty,
                          ),
                          CustomButton(
                            label: Strings.strContinue,
                              isLoading:false,
                            onPressed: () {
                           //   AppCommonFeatures.instance.contextInit(context);
                              UtilKlass.navigateScreen(OtpScreenForgot(userName: 'userName', userEmail: 'userEmail', userPassword: 'userPass'));

                            },
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
    );
  }
}

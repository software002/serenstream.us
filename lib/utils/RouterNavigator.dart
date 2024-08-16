import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:serenestream/auth/screens/login_screen.dart';
import 'package:serenestream/auth/screens/otp_screen.dart';
import 'package:serenestream/auth/screens/register_screen.dart';
import 'package:serenestream/splash/splash_screen.dart';


class RouterNavigator {
  static const String initial = '/';
  static const String onBoarding = '/onBoarding';
  static const String loginScreen = '/LoginScreen';
  static const String signupScreen = '/SignUpScreen';
  static const String forgotPassword = '/ForgotPasswordScreen';
  static const String resetPassword = '/ResetPasswordScreen';
  static const String verifyOtp = '/VerifyOtpScreen';
  static const String userRole = '/UserRole';
  static const String completeProfile = '/CompleteProfile';
  static const String addAddress = '/AddAddress';
  static const String addRequestDetail = '/AddRequestDetail';
  static const String editParcelDetail = '/EditParcelDetail';
  static const String editDropOfDetail = '/EditDropOfDetail';
  static const String successPage = '/SuccessPage';
  static const String successTripPage = '/SuccessTripPage';
  static const String successRequestPage = '/SuccessRequestPage';
  static const String myRequestPage = '/MyRequestPage';
  static const String invitePage = '/InvitePage';
  static const String homePage = '/HomePage';
  static const String dashboardPage = '/DashBoardPage';
  static const String mapPage = '/MapPage';
  static const String accountPage = '/AccountPage';
  static const String myProfilePage = '/MyProfilePage';
  static const String passwordSuccessPage = '/passwordSuccessPage';
  static const String editPassportPage = '/EditPassportPage';
  static const String editNationalIDPage = '/EditNationalIDPage';
  static const String editBioPage = '/EditBioPage';
  static const String offersPage = '/OffersPage';
  static const String tripAllPage = '/TripAllPage';
  static const String parcelAllPage = '/ParcelAllPage';
  static const String tripDetailPage = '/TripDetailPage';
  static const String parcelDetailPage = '/ParcelDetailPage';
  static const String staticPage = '/StaticPage';
  static const String contactDetailEditPage = '/ContactDetailEditPage';
  static const String contactUsPage = '/ContactUsPage';
  static const String helpDeskPage = '/HelpDeskPage';
  static const String connectToStripe = '/ConnectToStripePage';
  static const String requestCategory = '/RequestCategory';
  static const String changePasswordScreen = '/ChangePasswordScreen';
  static const String dropOffDetailsScreen = '/DropOffDetailsScreen';
  static const String postTravelScreen = '/PostTravelScreen';
  static const String editTravelScreen = '/EditTravelScreen';

  static const String bookingRequestsScreen = '/BookingRequestsScreen';
  static const String cancelParcelScreen = '/CancelParcelScreen';
  static const String allUsersScreen = '/AllUsersScreen';
  static const String allCompaniesScreen = '/AllCompaniesScreen';

  static const String companyCompleteProfileScreen = '/CompanyCompleteProfileScreen';
  static const String searchAddressScreen = '/SearchAddressScreen';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case resetPassword:
       /* final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) =>  OtpScreen(arguments));
    */
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

import 'package:flutter/material.dart';

enum NavigateType { pushNamed, pushNamedReplaced, pushNamedAndRemoveUntil }

///This class is used for app navigation handling
class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final NavigationService _singleton = NavigationService._internal();

  factory NavigationService() {
    return _singleton;
  }

  NavigationService._internal();

  static Future<dynamic> navigateTo(
    String routeName, {
    Object? arguments,
    BuildContext? context,
    NavigateType navigateType = NavigateType.pushNamed,
  }) async {
    await removeKeyboard(context: context);

    var isNewRouteSameAsCurrent = false;

    Navigator.popUntil(context ?? navigatorKey.currentContext!, (route) {
      if (route.settings.name == routeName) {
        isNewRouteSameAsCurrent = true;
      }
      return true;
    });

    if (isNewRouteSameAsCurrent &&
        navigateType != NavigateType.pushNamedAndRemoveUntil) {

      return Navigator.pushReplacementNamed(
        context ?? navigatorKey.currentContext!,
        routeName,
        arguments: arguments,
      );
    }

    switch (navigateType) {
      case NavigateType.pushNamed:
        return Navigator.pushNamed(
          context ?? navigatorKey.currentContext!,
          routeName,
          arguments: arguments,
        );
      case NavigateType.pushNamedReplaced:
        return Navigator.pushReplacementNamed(
          context ?? navigatorKey.currentContext!,
          routeName,
          arguments: arguments,
        );
      case NavigateType.pushNamedAndRemoveUntil:
        return Navigator.pushNamedAndRemoveUntil(
          context ?? navigatorKey.currentContext!,
          routeName,
          (route) => false,
          arguments: arguments,
        );
    }
  }


  static Future<void> removeKeyboard({BuildContext? context}) async {
    final currentFocus = FocusScope.of(
      context ?? NavigationService.navigatorKey.currentContext!,
    );
    if (!currentFocus.hasPrimaryFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}



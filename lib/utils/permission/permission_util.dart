import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Constants/strings.dart';

class PermissionUtil {
  PermissionUtil._();

  //permission handling
  static Future<PermissionStatus?> getPermission(
    Permission permissionType,
  ) async {
    final permission = await permissionType.status;
    if (permission != PermissionStatus.granted ||
        permission == PermissionStatus.denied) {
      final permissionStatus = await [permissionType].request();
      return permissionStatus[permissionType];
    } else {
      return permission;
    }
  }

  /*------------- permission dialog while permission denied manual permission handling -------------*/
  static Future<void> showActionDialog({
    BuildContext? context,
    String? description,
    bool shouldShowNegative = true,
    String? positiveText,
    String? negativeText,
    Permission? permissionType,
    GestureTapCallback? onPositiveClick,
    GestureTapCallback? onNegativeClick,
    String title = '',}) async {
    await showDialog<void>(
      context: context!,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Platform.isIOS
              ? CupertinoAlertDialog(
                  title: /* title != ""
                    ? */
                      Text(title)
                  /*: Row(children: [
                  Image.asset(
                    AppIcons.appLogoWithoutName,
                     width: SizeConfig.size_22,
                    height: SizeConfig.size_22,
                  ),
                  SizedBox(width: SizeConfig.size_8),
                  const Text(AppStrings.appName)
                ])*/
                  ,
                  content: Text(
                    description!,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    if (shouldShowNegative)
                      CupertinoDialogAction(
                        onPressed: onNegativeClick ??
                            () {
                              Navigator.pop(context);
                            },
                        child: Text(negativeText ?? Strings.cancel),
                      ),
                    CupertinoDialogAction(
                      onPressed: onPositiveClick ??
                          () {
                            Navigator.pop(context);
                            unawaited(openAppSettings());
                          },
                      child: Text(positiveText ?? Strings.appName),
                    ),
                  ],
                )
              : AlertDialog(
                  title: /* title != ""
                    ? */
                      Text(title)
                  /*: Row(children: [
                  Image.asset(
                    AppIcons.appLogoWithoutName,
                     width: SizeConfig.size_22,
                    height: SizeConfig.size_22,
                  ),
                  SizedBox(width: SizeConfig.size_8),
                  const Text(AppStrings.appName)
                ])*/
                  ,
                  content: Text(description!),
                  actions: [
                    if (shouldShowNegative)
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          minimumSize: const Size(85, 36),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onPressed: onNegativeClick ??
                            () {
                              Navigator.of(context).pop();
                            },
                        child: Text(
                          negativeText ?? Strings.cancel,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        minimumSize: const Size(85, 36),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onPressed: onPositiveClick ??
                          () {
                            Navigator.of(context).pop();
                            unawaited(openAppSettings());
                          },
                      child: Text(
                        positiveText ?? Strings.appName,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

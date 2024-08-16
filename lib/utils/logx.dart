import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' as Foundation;

class LogX{


  // Print log

  static void printLog(String logMsg){

    if(!Foundation.kReleaseMode){

     // App in debug mode

      Logger().d(logMsg);

   }
  }

  // Print waring log with yellow color

  static void printWaring(String logMsg){

    if(!Foundation.kReleaseMode){

      // App in debug mode

      var logger = Logger(
        printer: PrettyPrinter(
          colors: true,
        ),
      );

      logger.w(logMsg);

    }

  }

  // Print error log with red color

  static void printError(String logMsg){

    if(!Foundation.kReleaseMode){

      // App in debug mode

      var logger = Logger(
        printer: PrettyPrinter(
          colors: true,
        ),
      );

      logger.e(logMsg);

    }

  }

}
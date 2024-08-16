

import 'package:get_storage/get_storage.dart';

enum StorageAppleKeys {
  appleEmail,
  appleFirstName,
  appleLastName

}

class StorageServiceApple {
  static GetStorage? _prefs;


  static init() {
    _prefs = GetStorage("netwrk_mobile_apple");
  }

  // Save
  static saveData(String key, dynamic value) {

    _prefs?.write(key, value);
  }

  // Get
  static dynamic getData(String key, dynamic defaultValue) {

    if (_prefs!.hasData(key)) {
      return _prefs?.read(key);
    } else {
      return defaultValue;
    }
  }

  // Remove
  static void removeData(String key) {
    _prefs?.remove(key);
  }

  // Clear
  static void clearData() {
    _prefs?.erase();
  }

}

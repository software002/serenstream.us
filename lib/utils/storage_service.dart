import 'package:get_storage/get_storage.dart';

enum StorageKeys {
  yesCount,
  isLogin,
  emailId,
  userName,
  isMorningQuizDone,
  isNoonQuizDone,
  isNightQuizDone,
  isNotification

}


class StorageService {
  static GetStorage? _prefs;


  static init() {
    _prefs = GetStorage();
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


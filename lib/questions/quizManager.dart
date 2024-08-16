import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/storage_service.dart';
import '../utils/util_klass.dart';

class QuizManager {
  int _score = 0;
  int _yesCount = 0;

  /// This method updates the score and the count of 'Yes' answers.
  void answerQuestion(int score, bool isYes) {
    _score += score;
    if (isYes) {
      _yesCount++;
    }
  }

  /// This method determines the mood based on the count of 'Yes' answers.
  String getMood() {
    _yesCount=StorageService.getData(StorageKeys.yesCount.toString(), "");
    if (_yesCount >= 11) {
      return 'Happy';
    } else if (_yesCount >= 8) {
      return 'Normal';
    } else if (_yesCount >= 6) {
      return 'Sad';
    } else {
      return 'Mad';
    }
  }

  /// This method saves the mood to Firestore and SharedPreferences.
  Future<void> saveMood() async {
 //   final prefs = await SharedPreferences.getInstance();

    final date = DateTime.now().toIso8601String().split('T').first;

    final mood = getMood();

    try {

      var mood_map = <String, dynamic>{
        'date': date,
        'mood': mood,
        'email': StorageService.getData(StorageKeys.emailId.toString(),""),
        'yesCount':StorageService.getData(StorageKeys.yesCount.toString(), 0)
      };

      FirebaseFirestore.instance
          .collection('weeklymood').doc("${date.toString()}--${StorageService.getData(StorageKeys.emailId.toString(),"")}").
      set(mood_map).then((value) => UtilKlass.hideProgressAppLoading(),);

      /*await FirebaseFirestore.instance.collection('weeklymood').add({
        'date': date,
        'mood': mood,
        'yesCount':StorageService.getData(StorageKeys.yesCount.toString(), ""),
      });
      await prefs.setString('mood_$date', mood);*/
      // Optionally, store the mood in shared preferences for later use

    } catch (e) {
      print('Error saving mood to Firestore: $e');
      // Optionally handle the error or retry saving the data
    }
  }
}

import 'package:flutter/material.dart';
import 'package:serenestream/questions/questionManager.dart';
import 'package:serenestream/questions/quiz.dart';
import 'package:serenestream/questions/quizManager.dart';
import 'package:serenestream/utils/util_klass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/commonWidget.dart';
import '../utils/storage_service.dart';


class TestMoodScreen extends StatefulWidget {
  @override
  _TestMoodScreenState createState() => _TestMoodScreenState();
}

class _TestMoodScreenState extends State<TestMoodScreen> {
  final CommonWidget commonWidget = CommonWidget();

  final List<Map<String, Object>> _questions = [
    {'questionText': 'Are you taking work or stress to bed with you?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'night'},
    {'questionText': 'Do you feel satisfied with what you accomplished today?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'night'},
    {'questionText': 'Are you anxious about tomorrow?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'night'},
    {'questionText': 'Have you had any time to unwind before bed?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'night'},
    {'questionText': 'Are you engaging in any relaxation routines?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'night'},
    {'questionText': 'Do you anticipate trouble sleeping tonight?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'night'},
    {'questionText': 'Did you spend quality time with loved ones today?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'night'},
    {'questionText': 'Are you going to bed at your intended time?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'night'},
    {'questionText': 'Have you reflected on anything positive today?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'night'},
    {'questionText': 'Do you feel physically and mentally ready to sleep?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'night'},


    {'questionText': 'Have you felt overwhelmed by tasks today?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'noon'},
    {'questionText': 'Are you able to concentrate on your tasks?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'noon'},
    {'questionText': 'Have you skipped any meals due to busyness or stress?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'noon'},
    {'questionText': 'Do you feel you have someone to talk to if you stressed?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'noon'},
    {'questionText': 'Have you taken any breaks to relax today?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'noon'},
    {'questionText': 'Are you experiencing any physical symptoms of stress (e.g., headache,stomachache)?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'noon'},
    {'questionText': 'Have you felt irritable or more sensitive to small annoyances?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'noon'},
    {'questionText': 'Do you feel like you’re in control of your day?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'noon'},
    {'questionText': 'Have you had any moments of relief or happiness today?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'noon'},
    {'questionText': 'Are you managing to stay hydrated and eat healthily?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'noon'},

    {'questionText': 'Did you wake up feeling rested?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'morning'},
    {'questionText': 'Are you looking forward to your day?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'morning'},
    {'questionText': 'Do you feel anxious about today’s tasks?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'morning'},
    {'questionText': 'Did you have trouble sleeping last night?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'morning'},
    {'questionText': 'Are you worried about anything specific today?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'morning'},
    {'questionText': 'Do you feel prepared for todays challenges?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'morning'},
    {'questionText': 'Did you have any stress-related dreams?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'morning'},
    {'questionText': 'Are you concerned about your personal wellbeing today?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'morning'},
    {'questionText': 'Do you feel physically tense or uneasy?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'morning'},
    {'questionText': 'Are you procrastinating about starting your day?', 'answers': [{'text': 'Yes', 'score': 1}, {'text': 'No', 'score': 0}], 'time': 'morning'},

  ];

  late List<Map<String, Object>> _dailyQuestions;
  late QuizManager _quizManager;
  String currentPhase = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _quizManager = QuizManager();
    _setCurrentPhase();  // Set the initial phase based on device time
    _scheduleNextPhase();  // Schedule to change phase based on device time
    _dailyQuestions = _getDailyQuestions();  // Get today's questions
    print("daily**_dailyQuestions.length**${_dailyQuestions.length}");
  }

  List<Map<String, Object>> _getDailyQuestions() {
    // Shuffle the questions and pick 5 for each phase
    List<Map<String, Object>> morningQuestions = _questions.where((q) => q['time'] == 'morning').toList()..shuffle();
    List<Map<String, Object>> noonQuestions = _questions.where((q) => q['time'] == 'noon').toList()..shuffle();
    List<Map<String, Object>> nightQuestions = _questions.where((q) => q['time'] == 'night').toList()..shuffle();

    return [
      ...morningQuestions.take(5),
      ...noonQuestions.take(5),
      ...nightQuestions.take(5),
    ];
  }

  void _setCurrentPhase() {
    final now = DateTime.now();
    if (now.hour >= 0 && now.hour < 13) {
      currentPhase = 'morning';
    } else if (now.hour >= 13 && now.hour < 19) {
      currentPhase = 'noon';
    } else {
      currentPhase = 'night';
    }
  }

  void _scheduleNextPhase() {
    final now = DateTime.now();
    DateTime nextMorning = DateTime(now.year, now.month, now.day + 1, 0); // 12 am
    DateTime nextNoon = DateTime(now.year, now.month, now.day, 13); // 1 pm
    DateTime nextNight = DateTime(now.year, now.month, now.day, 19); // 7 pm

    if (now.isAfter(nextNight)) {
      // Move to next day's schedule
      nextMorning = nextMorning.add(Duration(days: 1));
      nextNoon = nextNoon.add(Duration(days: 1));
      nextNight = nextNight.add(Duration(days: 1));
    } else if (now.isAfter(nextNoon)) {
      _timer = Timer(nextNight.difference(now), () {
        setState(() {
          currentPhase = 'night';
          _scheduleNextPhase();
        });
      });
      return;
    } else if (now.isAfter(nextMorning)) {
      _timer = Timer(nextNoon.difference(now), () {
        setState(() {
          currentPhase = 'noon';
          _scheduleNextPhase();
        });
      });
      return;
    }

    _timer = Timer(nextMorning.difference(now), () {
      setState(() {
        currentPhase = 'morning';
        _scheduleNextPhase();
      });
    });
  }

  void _answerQuestion(int score, bool isYes) {
    _quizManager.answerQuestion(score, isYes);
    setState(() {
    //  _dailyQuestions.removeAt(0);
    });
  }

  /* void _answerQuestion(int score, bool isYes) {
    _quizManager.answerQuestion(score, isYes);
    setState(() {
      _dailyQuestions.removeAt(0);
    });
    if (_dailyQuestions.isEmpty) {
      setState(() {});
    }
  //for chart later use it for now comment
    *//* if (_dailyQuestions.isEmpty) {
      _quizManager.saveMood().then((_) {
        setState(() {});
      });
    }*//*

  }*/

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> phaseQuestions = _dailyQuestions.where((q) => q['time'] == currentPhase).toList();
    print("daily**phaseQuestions.length**${phaseQuestions.length}");
    var quizDone=false;
    if(UtilKlass.getCurrentPhase()=="Good Morning"){
      quizDone= StorageService.getData(StorageKeys.isMorningQuizDone.toString(), false);

    }else if(UtilKlass.getCurrentPhase()=="Good Night"){
      quizDone= StorageService.getData(StorageKeys.isNightQuizDone.toString(), false);

    }else if(UtilKlass.getCurrentPhase()=="Good afternoon"){
      quizDone= StorageService.getData(StorageKeys.isNoonQuizDone.toString(), false);

    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

      ),
      body: phaseQuestions.isEmpty || quizDone ? Center(child: commonWidget.title_breath("Thank you"))
          : Quiz(
        questions: phaseQuestions,
        answerQuestion: _answerQuestion,
        timePhase:UtilKlass.getCurrentPhase(),
      ),
/*      body: phaseQuestions.isEmpty
          ? Center(
        child: Text(
          'Your mood is: ${_quizManager.getMood()}',
          style: TextStyle(fontSize: 36),
        ),
      )
          : Quiz(
        questions: phaseQuestions,
        answerQuestion: _answerQuestion,
        timePhase:UtilKlass.getCurrentPhase(),
      ),*/
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}


import 'package:flutter/material.dart';
import 'package:serenestream/home/dashboard_screen.dart';
import 'package:serenestream/questions/quizManager.dart';
import 'package:serenestream/utils/util_klass.dart';

import '../utils/commonWidget.dart';
import '../utils/storage_service.dart';
import 'answer.dart';

class Quiz extends StatefulWidget {
  final List<Map<String, Object>> questions;
  final String timePhase;
  final Function(int, bool) answerQuestion;

  Quiz({required this.questions, required this.answerQuestion, required this.timePhase});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _questionIndex = 0;
  final CommonWidget commonWidget = CommonWidget();

  void _answerQuestion(int score, bool isYes) {
    if(isYes){
      int yes_count_old=StorageService.getData(StorageKeys.yesCount.toString(), 0);
      StorageService.saveData(
          StorageKeys.yesCount.toString(), yes_count_old+1);
    }

    debugPrint("yescount******${StorageService.getData(StorageKeys.yesCount.toString(), "")}");
    print("daily**widget.questions.length**${widget.questions.length}");
    print("daily**_questionIndex**${_questionIndex}");

    widget.answerQuestion(score, isYes);

    setState(() {
      if (_questionIndex < widget.questions.length) {
        _questionIndex++;
        print("Question index incremented: $_questionIndex");
      } else {
        print("Navigating to DashboardScreen");
        UtilKlass.navigateScreen(DashboardScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if(_questionIndex==5){
      QuizManager _quizManager = QuizManager();
      _quizManager.saveMood();
      if(widget.timePhase=="Good Morning"){
        StorageService.saveData(StorageKeys.isMorningQuizDone.toString(), true);

      }else if(widget.timePhase=="Good Night"){
        StorageService.saveData(StorageKeys.isNightQuizDone.toString(), true);

      }else if(widget.timePhase=="Good afternoon"){
        StorageService.saveData(StorageKeys.isNoonQuizDone.toString(), true);

      }
    }

    debugPrint("_questionIndex****$_questionIndex");
    debugPrint("widget.questions.length***${widget.questions.length}");


    return Padding(
      padding: const EdgeInsets.all(15),
      child: _questionIndex < widget.questions.length
          ? Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              widget.questions[_questionIndex]['questionText'] as String,
              style: TextStyle(fontSize: 16),
            ),
          ),
          ...(widget.questions[_questionIndex]['answers'] as List<Map<String, Object>>).map((answer) {
            return Answer(
                    () => _answerQuestion(answer['score'] as int, answer['text'] == 'Yes'),
                answer['text'] as String
            );
          }).toList(),
        ],
      )
          : Center(child: commonWidget.title_breath("Thank you")) ,
    );
  }


 /* void _answerQuestion(int score, bool isYes) {
    widget.answerQuestion(score, isYes);
    setState(() {
      _questionIndex++;
    });
  }*/





 /* @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child:_questionIndex < widget.questions.length
          ?  Column(
        children: [
          Text(
            widget.questions[_questionIndex]['questionText'] as String,
            style: TextStyle(fontSize: 16),
          ),
          ...(widget.questions[_questionIndex]['answers'] as List<Map<String, Object>>).map((answer) {
            return Answer(() => _answerQuestion(answer['score'] as int, answer['text'] == 'Yes'), answer['text'] as String);
          }).toList(),
        ],
      ) : Text(""),
    );
  }*/
}

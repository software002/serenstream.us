import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style:ElevatedButton.styleFrom(backgroundColor:  answerText=="Yes" ? Colors.green : Colors.red,) ,
        onPressed: selectHandler,
        child: Text(answerText,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
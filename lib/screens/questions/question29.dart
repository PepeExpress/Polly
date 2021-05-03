import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question29 extends StatelessWidget {
  Question29({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'I petali sono fusi solo alla base per un brevissimo tratto?',
        onYesPressed: () => {/**TIPO BORRAGGINE E POMODORO */},
        onNoPressed: () => {c.appPageController.value.jumpToPage(29)},
      ),
    );
  }
}

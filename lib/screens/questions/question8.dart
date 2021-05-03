import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question8 extends StatelessWidget {
  Question8({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Ha il fiore a “pon pon” e la pianta è legnosa?',
        onYesPressed: () => {/**TIPO MIMOSA */},
        onNoPressed: () => {/**LEGUMINOSE ERBACEE */},
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question24 extends StatelessWidget {
  Question24({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Ha la foglia tripartita (tipo trifoglio)?',
        onYesPressed: () => {/**ACETOSELLE */},
        onNoPressed: () => {/**GAROFANO */},
      ),
    );
  }
}

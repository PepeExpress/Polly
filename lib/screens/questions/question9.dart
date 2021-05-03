import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question9 extends StatelessWidget {
  Question9({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: "E' una pianta legnosa (arbusto o albero)?",
        onYesPressed: () => {/**Tipo SAMBUCO */},
        onNoPressed: () => {/**TIPO CAROTA */},
      ),
    );
  }
}

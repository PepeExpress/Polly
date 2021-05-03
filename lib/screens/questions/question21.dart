import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question21 extends StatelessWidget {
  Question21({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: "E' rampicante?",
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"VITALBE": "assets/graphics/vitalbe.PNG"},
                  "La pianta appartiene alla famiglia delle vitalbe"))
        },
        onNoPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"PAPAVERO": "assets/graphics/papavero.PNG"},
                  "La pianta appartiene alla famiglia del papavero"))
        },
      ),
    );
  }
}

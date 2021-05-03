import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question27 extends StatelessWidget {
  Question27({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question:
            "E' una pianta erbacea con fiori bianchi o gialli e petali lucidi?",
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"RANUNCOLO": "assets/graphics/ranuncolo.PNG"},
                  "La pianta appartiene alla famiglia del ranuncolo"))
        },
        onNoPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"ROSA": "assets/graphics/rosa.PNG"},
                  "La pianta appartiene alla famiglia delle rose"))
        },
      ),
    );
  }
}

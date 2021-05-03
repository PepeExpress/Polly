import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question11 extends StatelessWidget {
  Question11({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question:
            'Guardando il fiore, esternamente ci sono “petali” più larghi (tipo margherita) e internamente i fiori hanno forma diversa?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"MARGHERITA": "assets/graphics/margherita.PNG"},
                  "La pianta appartiene alla famiglia delle margherite"))
        },
        onNoPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"TARASSACO": "assets/graphics/tarassaco.PNG"},
                  "La pianta appartiene alla famiglia del tarassaco"))
        },
      ),
    );
  }
}

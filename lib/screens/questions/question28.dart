import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question28 extends StatelessWidget {
  Question28({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question:
            'I petali sono completamente fusi per tutta la loro lunghezza?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"CAMPANELLA": "assets/graphics/campanella.PNG"},
                  "La pianta appartiene alla famiglia delle campanelle"))
        },
        onNoPressed: () => {c.appPageController.value.jumpToPage(28)},
      ),
    );
  }
}

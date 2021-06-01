import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question8 extends StatelessWidget {
  Question8({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Ha il fiore a “pon pon” e la pianta è legnosa?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/result',
            (route) => false,
            arguments: ResultScreenArguments(
              {"MIMOSA": "assets/graphics/mimosa.PNG"},
              "La pianta appartiene alla famiglia della mimosa",
              [7],
            ),
          )
        },
        onNoPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/result',
            (route) => false,
            arguments: ResultScreenArguments(
              {"LEGUMINOSE ERBACEE": "assets/graphics/leguminose.PNG"},
              "La pianta appartiene alla famiglia delle leguminose",
              [8],
            ),
          )
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question16 extends StatelessWidget {
  Question16({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Ha fusto quadrangolare ed è aromatica?',
        onYesPressed: () => {
          /**TIPO SALVIA FAMIGLIA LAMIACEAE */
        },
        onNoPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/result',
            (route) => false,
            arguments: ResultScreenArguments(
              {"BOCCA DI LEONE": "assets/graphics/scropularia.PNG"},
              "La pianta appartiene alla famiglia delle scrofulariaceae",
              [19],
            ),
          )
        },
      ),
    );
  }
}

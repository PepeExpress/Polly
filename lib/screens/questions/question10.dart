import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question10 extends StatelessWidget {
  Question10({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Alla base del fiore sono presenti strutture spinose?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/result',
            (route) => false,
            arguments: ResultScreenArguments(
              {"CARDO": "assets/graphics/cardo.PNG"},
              "La pianta appartiene alla famiglia dei cardi",
              [11],
            ),
          )
        },
        onNoPressed: () => {c.appPageController.jumpToPage(10)},
      ),
    );
  }
}

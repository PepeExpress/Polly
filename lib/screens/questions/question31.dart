import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question31 extends StatelessWidget {
  Question31({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Il fiore ha una parte centrale a forma di coroncina?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/result',
            (route) => false,
            arguments: ResultScreenArguments(
              {"NARCISO": "assets/graphics/narciso.PNG"},
              "La pianta appartiene alla famiglia dei narcisi",
              [37],
            ),
          )
        },
        onNoPressed: () => {c.appPageController.jumpToPage(2)},
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question26 extends StatelessWidget {
  Question26({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'La corolla è leggermente imbutiforme?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/result',
            (route) => false,
            arguments: ResultScreenArguments(
              {"MALVA": "assets/graphics/malve.PNG"},
              "La pianta appartiene alla famiglia delle malve",
              [28],
            ),
          )
        },
        onNoPressed: () => {c.appPageController.jumpToPage(26)},
      ),
    );
  }
}

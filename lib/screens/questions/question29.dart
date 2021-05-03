import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question29 extends StatelessWidget {
  Question29({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'I petali sono fusi solo alla base per un brevissimo tratto?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments({
                "BORRAGGINE": "assets/graphics/borraggine.PNG",
                "POMODORO": "assets/graphics/pomodoro.PNG"
              }, "La pianta appartiene alla famiglia della borraggine o del pomodoro"))
        },
        onNoPressed: () => {c.appPageController.value.jumpToPage(29)},
      ),
    );
  }
}

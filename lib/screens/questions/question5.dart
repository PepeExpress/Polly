import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question5 extends StatelessWidget {
  Question5({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Rompendo il fusto puoi notare abbondante lattice bianco?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"EUFORBIA": "assets/graphics/euforbie.PNG"},
                  "La pianta appartiene alla famiglia delle Euphorbiaceae"))
        },
        onNoPressed: () => {c.appPageController.value.jumpToPage(5)},
      ),
    );
  }
}

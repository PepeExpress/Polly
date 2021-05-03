import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question22 extends StatelessWidget {
  Question22({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Ci sono i sepali ben distinguibili dai petali?',
        onYesPressed: () => {c.appPageController.value.jumpToPage(22)},
        onNoPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"LLEBORO": "assets/graphics/lleboro.PNG"},
                  "La pianta appartiene alla famiglia del lleboro"))
        },
      ),
    );
  }
}

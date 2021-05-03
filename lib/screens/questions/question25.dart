import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question25 extends StatelessWidget {
  Question25({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Ha 3 sepali?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"CISTO": "assets/graphics/cisto.PNG"},
                  "La pianta appartiene alla famiglia del cisto"))
        },
        onNoPressed: () => {c.appPageController.value.jumpToPage(25)},
      ),
    );
  }
}

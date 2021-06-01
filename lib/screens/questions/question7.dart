import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question7 extends StatelessWidget {
  Question7({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'La foglia è semplice?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/result',
            (route) => false,
            arguments: ResultScreenArguments(
              {"EDERA GLOBULARIA": "assets/graphics/edera.PNG"},
              "La pianta appartiene alla famiglia dell'edera",
              [6],
            ),
          )
        },
        onNoPressed: () => {c.appPageController.jumpToPage(7)},
      ),
    );
  }
}

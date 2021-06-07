import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question17 extends StatelessWidget {
  Question17({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question:
            'I petali sono completamente separati uno dall’altro? Prova a staccarne uno per verificare!',
        onYesPressed: () => {c.appPageController.jumpToPage(17)},
        onNoPressed: () => {c.appPageController.jumpToPage(27)},
      ),
    );
  }
}

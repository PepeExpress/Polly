import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question13 extends StatelessWidget {
  Question13({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Il fiore è butterfly-like?',
        onYesPressed: () => {c.appPageController.value.jumpToPage(13)},
        onNoPressed: () => {c.appPageController.value.jumpToPage(14)},
      ),
    );
  }
}

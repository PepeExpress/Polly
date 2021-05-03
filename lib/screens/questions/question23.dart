import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question23 extends StatelessWidget {
  Question23({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'La corolla è profonda?',
        onYesPressed: () => {c.appPageController.value.jumpToPage(23)},
        onNoPressed: () => {c.appPageController.value.jumpToPage(24)},
      ),
    );
  }
}

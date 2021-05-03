import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question10 extends StatelessWidget {
  Question10({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Alla base del fiore sono presenti strutture spinose?',
        onYesPressed: () => {/**TIPO CARDO */},
        onNoPressed: () => {c.appPageController.value.jumpToPage(10)},
      ),
    );
  }
}

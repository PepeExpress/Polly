import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question4 extends StatelessWidget {
  Question4({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question:
            'I fiori sono piccoli e raggruppati fino a sembrare un unico fiore? Usa la lente per verificare!',
        onYesPressed: () => {c.appPageController.value.jumpToPage(4)},
        onNoPressed: () => {c.appPageController.value.jumpToPage(11)},
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question15 extends StatelessWidget {
  Question15({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: "E' un fiore bilabiato?",
        onYesPressed: () => {c.appPageController.value.jumpToPage(15)},
        onNoPressed: () => {/**VERBASCUM VERONICA VIOLA */},
      ),
    );
  }
}

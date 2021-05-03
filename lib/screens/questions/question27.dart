import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question27 extends StatelessWidget {
  Question27({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question:
            "E' una pianta erbacea con fiori bianchi o gialli e petali lucidi?",
        onYesPressed: () => {/**TIPO RANUNCOLO */},
        onNoPressed: () => {/**Rose */},
      ),
    );
  }
}

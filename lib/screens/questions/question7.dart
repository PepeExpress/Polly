import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question7 extends StatelessWidget {
  Question7({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'La foglia è semplice?',
        onYesPressed: () => {/**RISULTATO TIPO EDERA GLOBULARIA */},
        onNoPressed: () => {c.appPageController.value.jumpToPage(7)},
      ),
    );
  }
}

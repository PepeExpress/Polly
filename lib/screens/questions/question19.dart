import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question19 extends StatelessWidget {
  Question19({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Ha 4 sepali?',
        onYesPressed: () => {c.appPageController.jumpToPage(19)},
        onNoPressed: () => {c.appPageController.jumpToPage(20)},
      ),
    );
  }
}

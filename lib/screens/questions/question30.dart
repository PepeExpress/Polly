import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

class Question30 extends StatelessWidget {
  Question30({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Formano un tubetto stretto (trumpet-like)?',
        onYesPressed: () => {/**TIPO VINCA E PRIMULA*/},
        onNoPressed: () => {/**TIPO GENZIANA*/},
      ),
    );
  }
}

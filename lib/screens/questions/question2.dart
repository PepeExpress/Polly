import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';
import 'package:plant_classification/screens/result_screen.dart';

class Question2 extends StatelessWidget {
  Question2({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: YesNoQuestion(
        question: 'Il fiore è labiato e/o ha lo sperone?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"ORCHIDEE": "assets/graphics/orchid.PNG"},
                  "La pianta appartiene alla famiglia delle orchidee"))
        },
        onNoPressed: () => {c.appPageController.value.jumpToPage(30)},
      ),
    );
  }
}

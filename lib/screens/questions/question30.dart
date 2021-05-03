import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question30 extends StatelessWidget {
  Question30({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Formano un tubetto stretto (trumpet-like)?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments({
                "VINCA": "assets/graphics/vinca.PNG",
                "PRIMULA": "assets/graphics/primula.PNG"
              }, "La pianta appartiene alla famiglia della vinca o della primula"))
        },
        onNoPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"GENZIANA": "assets/graphics/genziana.PNG"},
                  "La pianta appartiene alla famiglia della genziana"))
        },
      ),
    );
  }
}

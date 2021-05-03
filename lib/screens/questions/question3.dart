import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

import '../result_screen.dart';

class Question3 extends StatelessWidget {
  Question3({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YesNoQuestion(
        question: 'Il fiore assomiglia a questo?',
        questionChild: Image(
          image: AssetImage('assets/graphics/iris.PNG'),
        ),
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  {"IRIS": "assets/graphics/iris.PNG"},
                  "La pianta appartiene alla famiglia delle Iridaceae"))
        },
        onNoPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments({
                "CIPOLLA": "assets/graphics/cipolla.PNG",
                "GIGLIO": "assets/graphics/giglio.PNG"
              }, "La pianta appartiene alla famiglia delle cipolle o dei gigli"))
        },
      ),
    );
  }
}

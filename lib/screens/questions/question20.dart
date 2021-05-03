import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/multiple_choice_question.dart';
import 'package:plant_classification/widgets/question_button.dart';

import '../result_screen.dart';

class Question20 extends StatelessWidget {
  Question20({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Widget> choices = [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: QuestionItem(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/result', (route) => false,
                arguments: ResultScreenArguments(
                    {"SENAPE": "assets/graphics/senape.PNG"},
                    "La pianta appartiene alla famiglia della senape"));
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Center(
            child: Text(
              "6",
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: QuestionItem(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/result', (route) => false,
                arguments: ResultScreenArguments(
                    {"CAPPERO": "assets/graphics/cappero.PNG"},
                    "La pianta appartiene alla famiglia del cappero"));
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Center(
            child: Text(
              "8+",
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ];
    return Container(
        child: MultipleChoiceQuestion(
      question: "Quanti petali ha il fiore?",
      choices: choices,
    ));
  }
}

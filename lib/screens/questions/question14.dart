import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/multiple_choice_question.dart';
import 'package:plant_classification/widgets/question_button.dart';

import '../result_screen.dart';

class Question14 extends StatelessWidget {
  Question14({Key? key}) : super(key: key);
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
              context,
              '/result',
              (route) => false,
              arguments: ResultScreenArguments(
                {"POLIGALA": "assets/graphics/polygala.PNG"},
                "La pianta appartiene alla famiglia della poligala",
                [14],
              ),
            );
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Center(
            child: Text(
              "3, raramente 5, solitamente fusi, e 8 STAMI",
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
              context,
              '/result',
              (route) => false,
              arguments: ResultScreenArguments(
                {"LEGUMI": "assets/graphics/legume1.PNG"},
                "La pianta appartiene alla famiglia dei legumi",
                [15],
              ),
            );
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Center(
            child: Text(
              "5, quello superiore molto evidente, quelli inferiori spesso fusi, 10 stami",
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/multiple_choice_question.dart';
import 'package:plant_classification/widgets/question_button.dart';

import '../result_screen.dart';

class Question18 extends StatelessWidget {
  Question18({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Widget> choices = [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: QuestionItem(
          onTap: () {
            c.appPageController.jumpToPage(18);
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Center(
            child: Text(
              "4",
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
            c.appPageController.jumpToPage(21);
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Center(
            child: Text(
              "5",
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
                {
                  "PEONIA": "assets/graphics/peonia.PNG",
                  "NINFEA": "assets/graphics/ninfea.PNG",
                  "MELOGRANO": "assets/graphics/melograno.PNG",
                },
                "La pianta appartiene ad una delle seguenti famiglie",
                [38, 39, 40],
              ),
            );
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Center(
            child: Text(
              "6+",
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

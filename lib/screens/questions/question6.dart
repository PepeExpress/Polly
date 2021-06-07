import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/multiple_choice_question.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';
import 'package:plant_classification/widgets/question_button.dart';

class Question6 extends StatelessWidget {
  Question6({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Widget> choices = [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: QuestionItem(
          onTap: () {
            c.appPageController.jumpToPage(6);
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Image(
                  image: AssetImage('assets/graphics/edera.PNG'),
                ),
              ),
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Center(
                  child: Text(
                    "Forma Sferica",
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: QuestionItem(
          onTap: () {
            c.appPageController.jumpToPage(8);
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Image(
                  image: AssetImage('assets/graphics/carota.PNG'),
                ),
              ),
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Center(
                  child: Text(
                    "Ombrella",
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: QuestionItem(
          onTap: () {
            c.appPageController.jumpToPage(9);
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Image(
                  image: AssetImage('assets/graphics/margherita.PNG'),
                ),
              ),
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Center(
                  child: Text(
                    "Capolino",
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: QuestionItem(
          onTap: () {
            c.appPageController.jumpToPage(11);
          },
          height: size.height / 8,
          width: size.width * 0.95,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Center(
                  child: Text(
                    "Nessuna di queste",
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ];
    return Container(
        child: MultipleChoiceQuestion(
      question: "A quale di queste forme assomiglia il fiore?",
      choices: choices,
    ));
  }
}
 // TODO
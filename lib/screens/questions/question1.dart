import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/multiple_choice_question.dart';
import 'package:plant_classification/widgets/question_button.dart';

class Question1 extends StatelessWidget {
  Question1({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Widget> choices = [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: QuestionItem(
          onTap: () {
            c.appPageController.jumpToPage(1);
          },
          height: size.height / 5,
          width: size.width * 0.95,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/graphics/mono_leaf.png'),
                    ),
                    Text(
                      "Foglia con vene parallele",
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Center(
                  child: Text(
                    "Ha un numero di petali multiplo di 3",
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
            c.appPageController.jumpToPage(3);
          },
          height: size.height / 5,
          width: size.width * 0.95,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: size.width * 0.5,
                  image: AssetImage('assets/graphics/dico_leaf.png'),
                ),
                Text(
                  'Foglia con forme complesse e vene ramificate',
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    ];

    return MultipleChoiceQuestion(
      question: 'Quali caratteristiche ha la pianta?',
      choices: choices,
    );
  }
}

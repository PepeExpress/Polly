import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/multiple_choice_question.dart';
import 'package:plant_classification/widgets/question_button.dart';

class Question12 extends StatelessWidget {
  Question12({Key? key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Widget> choices = [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: QuestionItem(
          onTap: () {
            c.appPageController.jumpToPage(12);
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
                  image: AssetImage('assets/graphics/zigomorfa.PNG'),
                ),
              ),
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Center(
                  child: Text(
                    "Zigomorfa (Un solo piano di simmetria)",
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
            c.appPageController.jumpToPage(16);
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
                  image: AssetImage('assets/graphics/attinomorfa.PNG'),
                ),
              ),
              Container(
                width: size.width * 0.95 / 2,
                height: size.width * 0.95,
                child: Center(
                  child: Text(
                    "Attinomorfa (più piani di simmetria)",
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
      question: "La simmetria del fiore è:",
      choices: choices,
    ));
  }
}

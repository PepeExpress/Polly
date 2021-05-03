import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';

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
        onNoPressed: () => {/*RISULTATO CIPOLLA E GIGLI*/},
        onYesPressed: () => {/*RISULTATO IRIS */},
      ),
    );
  }
}

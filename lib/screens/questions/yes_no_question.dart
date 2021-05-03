import 'package:flutter/material.dart';
import 'package:plant_classification/screens/questions/multiple_choice_question.dart';
import 'package:plant_classification/widgets/question_button.dart';

class YesNoQuestion extends StatelessWidget {
  final String question;
  final Function onYesPressed;
  final Function onNoPressed;
  final Widget questionChild;
  const YesNoQuestion(
      {Key key,
      this.question,
      this.onYesPressed,
      this.onNoPressed,
      this.questionChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        QuestionItem(
          width: size.width * 0.95,
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  question,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
              ),
              questionChild == null ? Container() : questionChild,
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QuestionItem(
              onTap: onYesPressed,
              child: Text(
                "SI",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            QuestionItem(
              onTap: onNoPressed,
              child: Text(
                "NO",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        )
      ],
    );
  }
}

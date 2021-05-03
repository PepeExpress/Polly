import 'package:flutter/material.dart';
import 'package:plant_classification/widgets/question_button.dart';

class MultipleChoiceQuestion extends StatelessWidget {
  final String question;
  final List<Widget> choices;
  const MultipleChoiceQuestion({Key key, this.question, this.choices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          question,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [...this.choices],
        ),
      ],
    );
  }
}

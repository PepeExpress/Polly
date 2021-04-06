import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/widgets/gradient_background.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    final size = MediaQuery.of(context).size;
    final QuizScreenArguments args =
        ModalRoute.of(context).settings.arguments as QuizScreenArguments;
    return MultipleGradientBG(
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    delegate.question + " 1",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
                        border: Border.all(color: Colors.white, width: 4),
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: FractionalOffset.center,
                          image: FileImage(
                            File(args.imagePath),
                          ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      height: size.height / 4,
                    ),
                  ),
                  Text(
                    delegate.qHasMoreThan6Petals,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () => {},
                          child: Text(
                            'Si',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/root', (route) => false)
                          },
                          child: Text(
                            'No',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreenArguments {
  final String imagePath;

  QuizScreenArguments(this.imagePath);
}

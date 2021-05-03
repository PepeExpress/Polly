import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/widgets/gradient_background.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    final ResultScreenArguments args =
        ModalRoute.of(context).settings.arguments as ResultScreenArguments;
    return Scaffold(
      body: Stack(
        children: [
          MultipleGradientBG(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Risultato ",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Container(
                      width: 64.0,
                      height: 64.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(
                            File(c.imagePath.value),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        args.textResult,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      args.carousel,
                      Text(
                        "Per verificare la tua classificazione clicca il pulsante avanti",
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                          icon: Icon(Icons.arrow_right_alt),
                          onPressed: () => {print("CIAO")})
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResultScreenArguments {
  final Widget carousel;
  final String textResult;

  ResultScreenArguments(this.carousel, this.textResult);
}

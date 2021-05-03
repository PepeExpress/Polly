import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/quiz_screen.dart';
import 'package:plant_classification/widgets/gradient_background.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    GestureDetector(
                      onTap: () => {
                        c.resetQuiz(),
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/quiz', (route) => false,
                            arguments: QuizScreenArguments(c.imagePath.value))
                      },
                      child: Container(
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
                      CarouselSlider(
                        items: args.carouselItems.entries.map((i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width / 2,
                              height: size.height / 5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: Text(
                                      i.key,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  Image(
                                    height: size.height / 6,
                                    image: AssetImage(i.value),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        options: c.carouselOptions,
                      ),
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
  final Map<String, String> carouselItems;
  final String textResult;

  ResultScreenArguments(this.carouselItems, this.textResult);
}

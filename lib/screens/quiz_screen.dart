import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/widgets/gradient_background.dart';
import 'package:get/get.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizScreenArguments args =
        ModalRoute.of(context).settings.arguments as QuizScreenArguments;
    final QuizScreenController c =
        Get.put(QuizScreenController(args.imagePath));

    final delegate = S.of(context);
    c.initModel();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          MultipleGradientBG(),
          SafeArea(
            child: Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            "Domanda " + c.currentQuestion.toString(),
                            style: Theme.of(context).textTheme.headline2,
                          )),
                      GestureDetector(
                        onTap: () => {
                          c.appPageController.value.jumpToPage(0),
                          c.resetQuiz(),
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
                                File(args.imagePath),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      c.incrementQuestion();
                    },
                    controller: c.appPageController.value,
                    children: c.pages(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuizScreenArguments {
  final String imagePath;

  QuizScreenArguments(this.imagePath);
}

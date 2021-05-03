import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/questions/yes_no_question.dart';
import 'package:plant_classification/screens/result_screen.dart';

class Question2 extends StatelessWidget {
  Question2({Key key}) : super(key: key);
  final QuizScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: YesNoQuestion(
        question: 'Il fiore è labiato e/o ha lo sperone?',
        onYesPressed: () => {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false,
              arguments: ResultScreenArguments(
                  CarouselSlider(
                    items: [1].map((i) {
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Text(
                                  "ORCHIDEE",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Image(
                                height: size.height / 6,
                                image: AssetImage('assets/graphics/orchid.PNG'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    options: c.carouselOptions,
                  ),
                  "La pianta appartiene alla famiglia delle orchidee"))
        },
        onNoPressed: () => {c.appPageController.value.jumpToPage(2)},
      ),
    );
  }
}

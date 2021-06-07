import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/screens/questions/questions.dart';

class QuizScreenController extends GetxController {
  List<dynamic> predictions = [];
  var originalImage;
  var croppedImagePath;
  var appPageController = PageController();
  var currentQuestion = 1.obs;
  var carouselOptions = CarouselOptions(
    viewportFraction: 0.8,
    initialPage: 0,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlay: false,
    autoPlayInterval: Duration(seconds: 3),
    autoPlayAnimationDuration: Duration(milliseconds: 800),
    autoPlayCurve: Curves.fastOutSlowIn,
    enlargeCenterPage: false,
    scrollDirection: Axis.horizontal,
  );

  pages() => [
        Question1(),
        Question2(),
        Question3(),
        Question4(),
        Question5(),
        Question6(),
        Question7(),
        Question8(),
        Question9(),
        Question10(),
        Question11(),
        Question12(),
        Question13(),
        Question14(),
        Question15(),
        Question16(),
        Question17(),
        Question18(),
        Question19(),
        Question20(),
        Question21(),
        Question22(),
        Question23(),
        Question24(),
        Question25(),
        Question26(),
        Question27(),
        Question28(),
        Question29(),
        Question30(),
        Question31(),
      ];

  incrementQuestion() => currentQuestion++;
  resetQuiz() => currentQuestion = 1.obs;
  setPredictions(List<String> predictions) => this.predictions = predictions;
}

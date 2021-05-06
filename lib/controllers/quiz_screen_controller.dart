import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plant_classification/screens/questions/questions.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;

class QuizScreenController extends GetxController {
  QuizScreenController(String imagePath) {
    this.imagePath = imagePath.obs;
  }
  var imagePath;
  var appPageController = PageController().obs;
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

  Future loadModel() async {
    String res = await Tflite.loadModel(
      model: "assets/tensorflow/model.tflite",
      labels: "assets/tensorflow/labels.txt",
    );
    print("Result after loading the model: " + res);
  }

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

  initModel() async {
    await loadModel();
    tflite(imagePath.value);
  }

  Future tflite(String imagePath) async {
    var imageBytes = File(imagePath).readAsBytesSync().buffer;
    img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    img.Image resizedImage = img.copyResize(oriImage, height: 224, width: 224);

    var recognitions = await Tflite.runModelOnBinary(
      binary: imageToByteListUint8(resizedImage, 224).buffer.asUint8List(),
      threshold: 0.03,
    );
    print(recognitions);
  }

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  incrementQuestion() => currentQuestion++;
  resetQuiz() => currentQuestion = 1.obs;
}

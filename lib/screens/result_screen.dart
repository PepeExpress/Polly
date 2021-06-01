import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_classification/controllers/classifier.dart';
import 'package:plant_classification/controllers/herbary_screen_controller.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/quiz_screen.dart';
import 'package:plant_classification/screens/root_page.dart';
import 'package:plant_classification/widgets/gradient_background.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:image/image.dart' as img;

class ResultScreen extends StatefulWidget {
  ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final QuizScreenController c = Get.find();
  late Classifier _classifier;
  final HerbaryScreenController hc = Get.find();
  int result = -1;
  var appPageController = PageController();

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ResultScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as ResultScreenArguments;
    return Scaffold(
      body: Stack(
        children: [
          MultipleGradientBG(),
          SafeArea(
            child: PageView(
              controller: appPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Column(
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
                                arguments:
                                    QuizScreenArguments(c.croppedImagePath))
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
                                  File(c.croppedImagePath),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
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
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () async {
                              await _predict(c.croppedImagePath);
                              await checkIfCorrect(args.plantID);
                              await updateDB();
                              appPageController.jumpToPage(1);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
                result >= 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Classificazione Corretta!",
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Lottie.asset('assets/lottie/happy.json', width: 150),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height * 0.25,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: FileImage(
                                    File(c.originalImage),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            hc.plants![result].name,
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Text(
                            "E' la prima volta che trovi questa pianta! Da ora puoi vederla nel tuo erbario",
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "+50 punti",
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/root', (route) => false);
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Classificazione Sbagliata!",
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Lottie.asset('assets/lottie/sad.json', width: 150),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height * 0.25,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: FileImage(
                                    File(c.originalImage),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Secondo i nostri potenti bot la pianta dovrebbe essere una di queste",
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView(
                                    children: c.predictions.map((e) {
                                      return Flexible(
                                        child: Text(
                                          e.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.refresh,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/camera', (route) => false);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.home),
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/root', (route) => false);
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _predict(String path) async {
    img.Image imageInput = img.decodeImage(File(path).readAsBytesSync())!;
    List<Category> pred = _classifier.predict(imageInput);
    c.predictions = pred.map((e) => e.label).toList();
  }

  Future<int> checkIfCorrect(List<int> plantID) async {
    plantID.forEach((plant) {
      List<dynamic> classResults = hc.plants!
          .firstWhere((element) => element.id == plant)
          .classificationResults;
      print("classes " + classResults.toString());
      print("predictions " + c.predictions.toString());
      if (classResults.length > 0) {
        if (classResults.any((str) => c.predictions.any((element) =>
            element.contains(new RegExp(r'' + str.toString() + '',
                caseSensitive: false))))) {
          setState(() {
            result = plant - 1;
          });
        }
      }
    });
    return result;
  }

  Future updateDB() async {
    await hc.discoverPlant(result);
  }
}

class ResultScreenArguments {
  final Map<String, String> carouselItems;
  final String textResult;
  final List<int> plantID;

  ResultScreenArguments(this.carouselItems, this.textResult, this.plantID);
}

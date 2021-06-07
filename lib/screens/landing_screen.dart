import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/herbary_screen_controller.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/db/plants_database.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/utils/globals.dart';
import 'package:plant_classification/widgets/gradient_background.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    //Initialize database
    _initDB();
    Get.put(QuizScreenController());

    //Controllare se l'utente è loggato

    Future.delayed(Duration(seconds: 1)).then((value) => isUserAuthenticated
        ? Navigator.pushReplacementNamed(context, '/root')
        : Navigator.pushReplacementNamed(context, '/login'));
  }

  Future _initDB() async {
    var plants = await PlantsDatabase.instance.readAllPlants();
    Get.put(HerbaryScreenController(plants));
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Scaffold(
      body: MultipleGradientBG(
        child: Center(
          child: Text(
            delegate.loginCheck,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

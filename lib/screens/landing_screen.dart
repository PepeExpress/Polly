import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/herbary_screen_controller.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/db/badges_database.dart';
import 'package:plant_classification/db/plants_database.dart';
import 'package:plant_classification/db/quotes_database.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/utils/auth/authentication_controller.dart';
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
    Future.delayed(Duration(milliseconds: 1500),
        () => Navigator.pushReplacementNamed(context, '/root'));
    // AuthenticationController ac = Get.find();
    // //Controllare se l'utente è loggato
    // ac.authStateChanges.listen((User? user) {
    //   if (user == null) {
    //     print('Utente non loggato');
    //     Navigator.pushReplacementNamed(context, '/login');
    //     dispose();
    //   } else {
    //     print('Utente loggato');
    //     Navigator.pushReplacementNamed(context, '/root');
    //     dispose();
    //   }
    // });
  }

  Future _initDB() async {
    var plants = await PlantsDatabase.instance.readAllPlants();
    var quotes = await QuotesDatabase.instance.readAllQuotes();
    var badges = await BadgesDatabase.instance.readAllBadges();
    Get.put(HerbaryScreenController(plants, quotes, badges));
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

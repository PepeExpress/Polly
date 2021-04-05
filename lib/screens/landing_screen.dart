import 'package:flutter/material.dart';
import 'package:plant_classification/utils/globals.dart';
import 'package:plant_classification/widgets/gradient_background.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    print("Hello");
    //Controllare se l'utente è loggato

    Future.delayed(Duration(seconds: 1)).then((value) => isUserAuthenticated
        ? Navigator.pushReplacementNamed(context, '/home')
        : Navigator.pushReplacementNamed(context, '/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MultipleGradientBG(
        child: Center(child: Text("Controllo se sei loggato")),
      ),
    );
  }
}

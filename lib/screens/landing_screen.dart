import 'package:flutter/material.dart';
import 'package:plant_classification/generated/l10n.dart';
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
    //Controllare se l'utente è loggato

    Future.delayed(Duration(seconds: 1)).then((value) => isUserAuthenticated
        ? Navigator.pushReplacementNamed(context, '/root')
        : Navigator.pushReplacementNamed(context, '/login'));
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

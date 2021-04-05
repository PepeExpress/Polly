import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_classification/screens/camera_screen.dart';
import 'package:plant_classification/screens/herbary_screen.dart';
import 'package:plant_classification/screens/home_screen.dart';
import 'package:plant_classification/screens/landing_screen.dart';
import 'package:plant_classification/screens/leaderboard_screen.dart';
import 'package:plant_classification/screens/login_screen.dart';
import 'package:plant_classification/screens/quiz_screen.dart';
import 'package:plant_classification/screens/user_screen.dart';
import 'package:plant_classification/utils/globals.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  firstCamera = cameras.first;
  print(firstCamera);

  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Classification',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        //accentColor: Colors.transparent,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
          headline2: TextStyle(
              fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
          headline3: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          bodyText1: TextStyle(
              fontSize: 24, fontWeight: FontWeight.normal, color: Colors.black),
          bodyText2: TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingScreen(),
        '/login': (context) => LoginScreen(),
        '/user': (context) => UserScreen(),
        '/leaderboard': (context) => LeaderboardScreen(),
        '/herbary': (context) => HerbaryScreen(),
        '/home': (context) => HomeScreen(),
        '/camera': (context) => TakePictureScreen(
              camera: firstCamera,
            ),
        '/quiz': (context) => QuizScreen()
      },
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

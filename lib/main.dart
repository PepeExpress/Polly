import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_classification/db/plants_database.dart';
import 'screens/screens.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PlantsDatabase.instance.database;
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
              fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingScreen(),
        '/root': (context) => RootPage(),
        '/login': (context) => LoginScreen(),
        '/user': (context) => UserScreen(),
        '/leaderboard': (context) => LeaderboardScreen(),
        '/herbary': (context) => HerbaryScreen(),
        '/home': (context) => HomeScreen(),
        '/camera': (context) => TakePictureScreen(),
        '/quiz': (context) => QuizScreen(),
        '/result': (context) => ResultScreen(),
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

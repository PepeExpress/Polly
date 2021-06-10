import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plant_classification/db/plants_database.dart';
import 'package:plant_classification/screens/detail_screen.dart';
import 'package:plant_classification/utils/auth/authentication_controller.dart';
import 'screens/screens.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PlantsDatabase.instance.database;
  await GetStorage.init();
  _initStorage();
  Get.put<AuthenticationController>(
      AuthenticationController(FirebaseAuth.instance));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );
}

void _initStorage() {
  final storage = GetStorage();
  if (storage.read('usrImage') == null) {
    storage.write('usrImage', 0);
  }
  if (storage.read('username') == null) {
    storage.write('username', 'username');
  }
  if (storage.read('points') == null) {
    storage.write('points', 0);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Plant Classification',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 48, fontWeight: FontWeight.w600, color: Colors.black),
          headline2: TextStyle(
              fontSize: 36, fontWeight: FontWeight.w600, color: Colors.black),
          headline3: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
          bodyText1: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
          bodyText2: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          caption: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
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
        '/detail': (context) => DetailScreen(),
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

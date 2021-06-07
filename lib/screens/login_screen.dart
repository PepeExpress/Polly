import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:plant_classification/widgets/gradient_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleGradientBG(
      child: Center(
        child: FlutterLogin(
          onLogin: (LoginData) {
            Navigator.pushReplacementNamed(context, '/home');
          },
          onRecoverPassword: (String) {},
          onSignup: (LoginData) {},
          theme: LoginTheme(
            buttonStyle: TextStyle(color: Colors.black),
            buttonTheme: LoginButtonTheme(
              backgroundColor: Colors.white,
            ),
            inputTheme: InputDecorationTheme(),
            cardTheme: CardTheme(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

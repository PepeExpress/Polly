import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:plant_classification/utils/auth/authentication_controller.dart';
import 'package:plant_classification/widgets/gradient_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    AuthenticationController ac = Get.find();
    Future<String> _authUser(LoginData data) async {
      return await ac.signIn(email: data.name, password: data.password);
    }

    Future<String> _signUpUser(LoginData data) async {
      return await ac.signUp(email: data.name, password: data.password);
    }

    return MultipleGradientBG(
      child: Center(
        child: FlutterLogin(
          onLogin: _authUser,
          onSignup: _signUpUser,
          onRecoverPassword: (string) {
            print(string);
          },
          onSubmitAnimationCompleted: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/root', (route) => false);
          },
          theme: LoginTheme(
            buttonStyle: TextStyle(color: Colors.black),
            buttonTheme: LoginButtonTheme(
              backgroundColor: Colors.white,
            ),
            inputTheme: InputDecorationTheme(),
            cardTheme: CardTheme(color: Colors.white),
            pageColorLight: Colors.transparent,
            pageColorDark: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

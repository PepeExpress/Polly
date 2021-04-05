import 'package:flutter/material.dart';
import 'package:plant_classification/widgets/gradient_background.dart';
import 'package:plant_classification/widgets/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleGradientBG(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [CustomBottomNavigationBar()],
        ),
      ),
    );
  }
}

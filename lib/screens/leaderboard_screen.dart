import 'package:flutter/material.dart';
import 'package:plant_classification/widgets/gradient_background.dart';
import 'package:plant_classification/widgets/navigation_bar.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleGradientBG(
      child: SafeArea(
        child: Column(
          children: [
            Text(
              "Leaderboard",
              style: Theme.of(context).textTheme.headline1,
            ),
            Expanded(
              child: Stack(
                children: [
                  CustomBottomNavigationBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plant_classification/generated/l10n.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return SafeArea(
      child: Column(
        children: [
          Text(
            delegate.leaderboardScreenTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}

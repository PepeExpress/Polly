import 'package:flutter/material.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/widgets/gradient_background.dart';
import 'package:plant_classification/widgets/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return SafeArea(
      child: Column(
        children: [
          Text(
            delegate.homeScreenTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}

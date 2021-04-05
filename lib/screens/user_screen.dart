import 'package:flutter/material.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/widgets/gradient_background.dart';
import 'package:plant_classification/widgets/navigation_bar.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return MultipleGradientBG(
      child: SafeArea(
        child: Column(
          children: [
            Text(
              delegate.userScreenTitle,
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

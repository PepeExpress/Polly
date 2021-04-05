import 'package:flutter/material.dart';
import 'package:plant_classification/widgets/gradient_background.dart';
import 'package:plant_classification/widgets/navigation_bar.dart';

class HerbaryScreen extends StatelessWidget {
  const HerbaryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleGradientBG(
      child: SafeArea(
        child: Column(
          children: [
            Text(
              "Herbary",
              style: Theme.of(context).textTheme.headline1,
            ),
            Expanded(
              child: Stack(
                children: [
                  GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(3, (index) {
                      return Container(
                        child: Card(
                          color: Colors.amber,
                        ),
                      );
                    }),
                  ),
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

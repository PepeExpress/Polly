import 'dart:ui';

import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import 'package:plant_classification/screens/herbary_screen.dart';
import 'package:plant_classification/screens/home_screen.dart';
import 'package:plant_classification/screens/leaderboard_screen.dart';
import 'package:plant_classification/screens/user_screen.dart';
import 'package:plant_classification/widgets/navigation_bar.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 3;
  final _pages = [
    UserScreen(),
    LeaderboardScreen(),
    HerbaryScreen(),
    HomeScreen()
  ];
  var _appPageController = PageController(initialPage: 3);

  setBottomBarIndex(index) {
    setState(() {
      _currentIndex = index;
    });
    _appPageController.animateToPage(
      _currentIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          MultipleGradientBG(),
          PageView(
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            controller: _appPageController,
            children: _pages,
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onChange: (index) {
          setState(() {
            _currentIndex = index;
          });
          _appPageController.jumpToPage(index);
        },
      ),
      extendBody: true,
    );
  }
}

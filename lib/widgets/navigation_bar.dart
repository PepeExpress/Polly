import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Positioned(
        bottom: 0,
        left: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                ),
                color: Colors.white.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              width: size.width,
              height: size.height / 13,
              child: Stack(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.person_outlined),
                          onPressed: () => {navigateTo(context, '/user')},
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        IconButton(
                          icon: Icon(Icons.leaderboard_outlined),
                          onPressed: () =>
                              {navigateTo(context, '/leaderboard')},
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Stack(
                          children: [
                            IconButton(
                              icon: Icon(Icons.menu_book_sharp),
                              onPressed: () =>
                                  {navigateTo(context, '/herbary')},
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.home_outlined),
                          onPressed: () => {navigateTo(context, '/home')},
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    //heightFactor: 0,
                    child: Container(
                      width: 64,
                      height: 64,
                      child: FloatingActionButton(
                        onPressed: () => {navigateTo(context, '/camera')},
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void navigateTo(BuildContext context, String route) {
  String currentRoute = ModalRoute.of(context).settings.name;
  if (currentRoute == route) {
  } else {
    if (currentRoute == '/quiz') {
      //TODO - Mostrare popup che chiede all'utente se è sicuro
      //di sospendere il quiz e poi navigo alla route specificata
      //Per ora navigo direttamente senza mostrare il popup
      print("Utente ha sospeso il quiz");
      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
    } else {
      if (route == '/camera') {
        Navigator.pushNamed(context, '/camera');
      } else {
        Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
      }
    }
  }
}

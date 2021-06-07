import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({Key? key, this.currentIndex = 0, this.onChange})
      : super(key: key);
  final int currentIndex;
  final Function(int)? onChange;
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int cIndex = 3;
  var selectedCircleBottomPos = [-20.0, -20.0, -20.0, 5.0];

  void _changeIndex(int index) {
    if (widget.onChange != null) {
      widget.onChange!(index);
      setState(() {
        selectedCircleBottomPos[cIndex] = -20.0;
        selectedCircleBottomPos[index] = 5;
        cIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 13,
      color: Colors.transparent,
      child: Stack(
        children: [
          ClipShadowPath(
            shadow: Shadow(
              blurRadius: 4,
              color: Colors.grey.withOpacity(0.4),
              offset: Offset(0, -3.0),
            ),
            clipper: BNBCustomClipper(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipOval(
                        child: GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                child: Icon(
                                  Icons.person_outline,
                                  size: 28,
                                ),
                              ),
                              AnimatedPositioned(
                                duration: Duration(
                                  milliseconds: 250,
                                ),
                                bottom: selectedCircleBottomPos[0],
                                left: 24,
                                child: ClipOval(
                                  child: AnimatedContainer(
                                    width: 6,
                                    height: 6,
                                    color: cIndex == 0
                                        ? Colors.black
                                        : Colors.transparent,
                                    duration: Duration(
                                      milliseconds: 250,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () => {_changeIndex(0)},
                        ),
                      ),
                      ClipOval(
                        child: GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                child: Icon(
                                  Icons.leaderboard_outlined,
                                  size: 28,
                                ),
                              ),
                              AnimatedPositioned(
                                duration: Duration(
                                  milliseconds: 250,
                                ),
                                bottom: selectedCircleBottomPos[1],
                                left: 24,
                                child: ClipOval(
                                  child: AnimatedContainer(
                                    width: 6,
                                    height: 6,
                                    color: cIndex == 1
                                        ? Colors.black
                                        : Colors.transparent,
                                    duration: Duration(
                                      milliseconds: 250,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () => {_changeIndex(1)},
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      ClipOval(
                        child: GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                child: Icon(
                                  Icons.menu_book_outlined,
                                  size: 28,
                                ),
                              ),
                              AnimatedPositioned(
                                duration: Duration(
                                  milliseconds: 250,
                                ),
                                bottom: selectedCircleBottomPos[2],
                                left: 24,
                                child: ClipOval(
                                  child: AnimatedContainer(
                                    width: 6,
                                    height: 6,
                                    color: cIndex == 2
                                        ? Colors.black
                                        : Colors.transparent,
                                    duration: Duration(
                                      milliseconds: 250,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () => {_changeIndex(2)},
                        ),
                      ),
                      ClipOval(
                        child: GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                child: Icon(
                                  Icons.home_outlined,
                                  size: 28,
                                ),
                              ),
                              AnimatedPositioned(
                                bottom: selectedCircleBottomPos[3],
                                left: 24,
                                duration: Duration(
                                  milliseconds: 250,
                                ),
                                child: ClipOval(
                                  child: AnimatedContainer(
                                    width: 6,
                                    height: 6,
                                    color: cIndex == 3
                                        ? Colors.black
                                        : Colors.transparent,
                                    duration: Duration(
                                      milliseconds: 250,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () => {_changeIndex(3)},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            heightFactor: 0.6,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 6,
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5)
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [
                    Color(0xFF70F570),
                    Color(0xFF49C628),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: CircleBorder(),
                        splashColor: Colors.white.withOpacity(0.2),
                        onTap: () => {
                          navigateTo(context, '/camera'),
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void navigateTo(BuildContext context, String route) {
  String? currentRoute = ModalRoute.of(context)!.settings.name;
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

class BNBCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height); // Start
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(0, 0, size.height / 2, 0);
    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.lineTo(size.width - size.height / 2, 0);
    path.quadraticBezierTo(size.width, 0, size.width, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    required this.shadow,
    required this.clipper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({Key key, this.currentIndex = 0, this.onChange})
      : super(key: key);
  final int currentIndex;
  final Function(int) onChange;
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void _changeIndex(int index) {
    if (widget.onChange != null) {
      widget.onChange(index);
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
      child: Stack(
        children: [
          ClipShadowPath(
            shadow: Shadow(
              blurRadius: 4,
              color: Colors.grey.withOpacity(0.5),
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
                      IconButton(
                        icon: Icon(Icons.person_outlined),
                        onPressed: () => {_changeIndex(0)},
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      IconButton(
                        icon: Icon(Icons.leaderboard_outlined),
                        onPressed: () => {_changeIndex(1)},
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
                            onPressed: () => {_changeIndex(2)},
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.home_outlined),
                        onPressed: () => {_changeIndex(3)},
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
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
    @required this.shadow,
    @required this.clipper,
    @required this.child,
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

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

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

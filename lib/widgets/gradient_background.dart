import 'package:flutter/material.dart';
import '../utils/globals.dart';

class MultipleGradientBG extends StatelessWidget {
  final Widget child;
  const MultipleGradientBG({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [greenbg1, greenbg2],
            center: Alignment.topRight,
            radius: 1.0,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [redbg1, redbg2],
                center: Alignment.topLeft,
                radius: 0.8,
                focal: Alignment.topLeft),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [yellowbg1, yellowbg2],
                center: Alignment.center,
                radius: 0.9,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [purplebg1, purplebg2],
                  center: Alignment.bottomRight,
                  radius: 1.4,
                  focal: Alignment.bottomRight,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [bluebg1, bluebg2],
                    center: Alignment.bottomLeft,
                    radius: 1.5,
                  ),
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

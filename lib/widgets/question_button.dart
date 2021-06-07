import 'package:flutter/material.dart';

class QuestionItem extends StatelessWidget {
  final Widget? child;
  final Function? onTap;
  final double width;
  final double height;
  final Color backgroundColor;
  const QuestionItem(
      {Key? key,
      this.child,
      this.onTap,
      this.width = 140,
      this.height = 50,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      onTap: this.onTap as void Function()?,
      child: Container(
        width: this.width,
        height: this.height,
        decoration: BoxDecoration(
          color: this.backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: this.child,
        ),
      ),
    );
  }
}

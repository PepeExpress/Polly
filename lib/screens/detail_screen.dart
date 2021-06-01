import 'package:flutter/cupertino.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(tag: 'photo', child: Container()),
    );
  }
}

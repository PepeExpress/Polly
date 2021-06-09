import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_classification/model/badges.dart';

class BadgeDetail extends StatelessWidget {
  const BadgeDetail({Key? key, required this.badge, required this.heroTag})
      : super(key: key);
  final Badge badge;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.2),
        body: Center(
          child: Hero(
            tag: heroTag,
            child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 6,
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5)
                            ],
                          ),
                          child: CircleAvatar(
                            child: SvgPicture.asset(badge.imagePath),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          badge.description,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

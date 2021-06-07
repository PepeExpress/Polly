import 'package:flutter/material.dart';

class LeaderBoardEntry extends StatelessWidget {
  const LeaderBoardEntry(
      {Key? key,
      required this.index,
      required this.username,
      required this.points})
      : super(key: key);
  final int index;
  final String username;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          child: Text(
            index.toString() + "°",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              height: 50,
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Color(0xFFAAAAAA).withOpacity(0.5),
                          spreadRadius: 5,
                          offset: Offset(5, 0),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                    ),
                  ),
                  Text(
                    "@" + username,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      points.toString(),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 40,
        ),
      ],
    );
  }
}

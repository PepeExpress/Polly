import 'package:flutter/material.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/widgets/leaderboard_entry.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return SafeArea(
      child: Column(
        children: [
          Text(
            delegate.leaderboardScreenTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InkWell(
                  child: Text(
                    'Oggi',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  child: Text(
                    'Settimana',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InkWell(
                  child: Text(
                    'Anno',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Text(
                        '2°',
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFBDC3C7), width: 3),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                color: Color(0xFFBDC3C7),
                                spreadRadius: 5)
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                        ),
                      ),
                      Text(
                        '@gioia3',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '388',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    children: [
                      Text(
                        '1°',
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFF9CA24).withOpacity(0.5),
                              width: 3),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                color: Color(0xFFF9CA24).withOpacity(0.5),
                                spreadRadius: 5)
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                        ),
                      ),
                      Text(
                        '@marco58',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '421',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Column(
                    children: [
                      Text(
                        '3°',
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFD35400).withOpacity(0.5),
                              width: 3),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                color: Color(0xFFD35400).withOpacity(0.5),
                                spreadRadius: 5)
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                        ),
                      ),
                      Text(
                        '@simo22',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '350',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: ListView.separated(
                separatorBuilder: (context, i) {
                  return SizedBox(
                    height: 20,
                  );
                },
                itemBuilder: (context, i) {
                  return LeaderBoardEntry(
                    index: i + 4,
                    username: "username",
                    points: 200 - i,
                  );
                },
                itemCount: 7,
              ),
            ),
          )
        ],
      ),
    );
  }
}

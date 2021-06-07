import 'package:flutter/material.dart';
import 'package:plant_classification/generated/l10n.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return SafeArea(
      child: Column(
        children: [
          Text(
            delegate.userScreenTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6, color: Colors.white, spreadRadius: 5)
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5)
                      ],
                      gradient: LinearGradient(
                          colors: [Color(0xFFFEB692), Color(0xFFEA5455)]),
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        print("TODO: Logout");
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            '@username44',
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Classifica',
            style: Theme.of(context).textTheme.headline3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Oggi',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '1°',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Settimana',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '3°',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Anno',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '234°',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Badges',
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              padding: EdgeInsets.all(5.0),
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5)
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5)
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5)
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5)
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5)
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5)
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/firestore_controller.dart';
import 'package:plant_classification/controllers/herbary_screen_controller.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/widgets/leaderboard_entry.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirestoreDB fire = Get.find();
    HerbaryScreenController hc = Get.find();
    fire.getLeaderboard().then((value) => value.docs.forEach((element) {
          print(element['username'] + " " + element['points'].toString());
        }));
    final delegate = S.of(context);
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Text(
            delegate.leaderboardScreenTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
          FutureBuilder(
              future: fire.getLeaderboard(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var data = snapshot.data!.docs;
                  //data.sort((a, b) => b['points'].compareTo(a['points']));

                  return SingleChildScrollView(
                    child: Column(
                      children: [
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
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFBDC3C7), width: 3),
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
                                        backgroundImage: NetworkImage(hc
                                            .plants![data[1]['imgIndex']]
                                            .urlImage),
                                      ),
                                    ),
                                    Text(
                                      '@' + data[1]['username'],
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      data[1]['points'].toString(),
                                      style:
                                          Theme.of(context).textTheme.headline2,
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
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFF9CA24)
                                                .withOpacity(0.5),
                                            width: 3),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 6,
                                              color: Color(0xFFF9CA24)
                                                  .withOpacity(0.5),
                                              spreadRadius: 5)
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(hc
                                            .plants![data[0]['imgIndex']]
                                            .urlImage),
                                      ),
                                    ),
                                    Text(
                                      '@' + data[0]['username'],
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      data[0]['points'].toString(),
                                      style:
                                          Theme.of(context).textTheme.headline1,
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
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFD35400)
                                                .withOpacity(0.5),
                                            width: 3),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 6,
                                              color: Color(0xFFD35400)
                                                  .withOpacity(0.5),
                                              spreadRadius: 5)
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(hc
                                            .plants![data[2]['imgIndex']]
                                            .urlImage),
                                      ),
                                    ),
                                    Text(
                                      '@' + data[2]['username'],
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      data[2]['points'].toString(),
                                      style:
                                          Theme.of(context).textTheme.headline3,
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
                        Container(
                          height: 400,
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, i) {
                              return SizedBox(
                                height: 20,
                              );
                            },
                            itemBuilder: (context, i) {
                              return LeaderBoardEntry(
                                index: i + 4,
                                username: data[i + 3]['username'],
                                points: data[i + 3]['points'],
                                imgPath: hc
                                    .plants![data[i + 3]['imgIndex']].urlImage,
                              );
                            },
                            itemCount: 7,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

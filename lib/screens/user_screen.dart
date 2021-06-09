import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/herbary_screen_controller.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/screens/badge_detail_screen.dart';
import 'package:plant_classification/screens/landing_screen.dart';
import 'package:plant_classification/utils/auth/authentication_controller.dart';
import 'package:plant_classification/widgets/hero_badge_route.dart';
import 'package:plant_classification/widgets/navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    final delegate = S.of(context);
    HerbaryScreenController controller = Get.find();
    //AuthenticationController ac = Get.find();
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
                      onPressed: () async {
                        // await ac.signOut();
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, '/', (route) => false);
                        print("Logged out");
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          // FutureBuilder<DocumentSnapshot>(
          //   future: user.doc(ac.modelUser.value.uid).get(),
          //   builder: (BuildContext context,
          //       AsyncSnapshot<DocumentSnapshot> snapshot) {
          //     if (snapshot.hasError) {
          //       return Text("Something went wrong");
          //     }

          //     if (snapshot.hasData && !snapshot.data!.exists) {
          //       return Text("Document does not exist");
          //     }

          //     if (snapshot.connectionState == ConnectionState.done) {
          //       Map<String, dynamic> data =
          //           snapshot.data!.data() as Map<String, dynamic>;
          //       return Text(
          //         '@' + data['username'].toString(),
          //         style: Theme.of(context).textTheme.caption,
          //       );
          //     }

          //     return Text("loading");
          //   },
          // ),
          Text(
            '@username'.toString(),
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
          controller.getDiscoveredBadges().length > 0
              ? GetX<HerbaryScreenController>(builder: (controller) {
                  return Expanded(
                    child: GridView.count(
                      crossAxisCount: 5,
                      padding: EdgeInsets.all(5.0),
                      children: controller
                          .getDiscoveredBadges()
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    HeroDialogRoute(builder: (context) {
                                      return BadgeDetail(
                                          badge: e,
                                          heroTag: "badge" + e.id.toString());
                                    }),
                                  ),
                                  child: Hero(
                                    tag: "badge" + e.id.toString(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 6,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              spreadRadius: 5)
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 50,
                                        child: SvgPicture.asset(e.imagePath),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),

                      // [
                      // Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       shape: BoxShape.circle,
                      //       boxShadow: [
                      //         BoxShadow(
                      //             blurRadius: 6,
                      //             color: Colors.black.withOpacity(0.1),
                      //             spreadRadius: 5)
                      //       ],
                      //     ),
                      //     child: CircleAvatar(
                      //       radius: 50,
                      //       backgroundImage: NetworkImage(
                      //           'https://img.fotocommunity.com/fiorellino-di-campo-22e91e66-f1c5-4ce2-a376-0edf84644dfe.jpg?height=1080'),
                      //     ),
                      //   ),
                      // ),
                      // ],
                    ),
                  );
                })
              : Expanded(
                  child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Non hai ancora alcun badge ☹️",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                )),
        ],
      ),
    );
  }
}

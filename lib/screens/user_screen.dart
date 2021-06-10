import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/firestore_controller.dart';
import 'package:plant_classification/controllers/herbary_screen_controller.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/model/user.dart';
import 'package:plant_classification/screens/badge_detail_screen.dart';
import 'package:plant_classification/screens/landing_screen.dart';
import 'package:plant_classification/utils/auth/authentication_controller.dart';
import 'package:plant_classification/widgets/hero_badge_route.dart';
import 'package:plant_classification/widgets/navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    final delegate = S.of(context);
    var txt = TextEditingController();
    HerbaryScreenController controller = Get.find();
    AuthenticationController ac = Get.find();
    final storage = GetStorage();
    var userInfo = ac.modelUser;
    txt.text = userInfo.value.username;

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
                          controller.plants![userInfo.value.imgIndex].urlImage),
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
                        await ac.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                        print("Logged out");
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '@',
                style: Theme.of(context).textTheme.caption,
              ),
              IntrinsicWidth(
                child: Form(
                  key: GlobalKey<FormState>(),
                  autovalidateMode: AutovalidateMode.disabled,
                  child: TextFormField(
                    controller: txt,
                    validator: (value) {
                      return value!.length < 5 || value.length > 12
                          ? 'Il nome deve contenere più di 4 caratteri e meno di 12'
                          : null;
                    },
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.caption,
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.caption,
                    onFieldSubmitted: (value) {
                      if (value.length < 5 || value.length > 12) {
                        txt.text = userInfo.value.username;
                        Flushbar(
                          message:
                              "Il nome deve contenere più di 4 caratteri e meno di 12",
                          icon: Icon(
                            Icons.close,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          duration: const Duration(seconds: 3),
                          backgroundGradient: LinearGradient(
                            colors: [Colors.red[600]!, Colors.red[400]!],
                          ),
                          onTap: (flushbar) => flushbar.dismiss(),
                        )..show(context);
                      } else {
                        txt.text = value;
                        storage.write('username', value);
                        ac.modelUser(ModelUser(
                            username: value,
                            uid: ac.modelUser.value.uid,
                            imgIndex: ac.modelUser.value.imgIndex,
                            points: ac.modelUser.value.points));
                        Flushbar(
                          message: "Username aggiornato!",
                          icon: Icon(
                            Icons.check,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          duration: const Duration(seconds: 3),
                          backgroundGradient: LinearGradient(
                            colors: [Colors.green[600]!, Colors.green[400]!],
                          ),
                          onTap: (flushbar) => flushbar.dismiss(),
                        )..show(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Punti',
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            storage.read('points').toString(),
            style: Theme.of(context).textTheme.bodyText1,
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

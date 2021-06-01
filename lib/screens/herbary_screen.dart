import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/herbary_screen_controller.dart';
import 'package:plant_classification/db/plants_database.dart';
import 'package:plant_classification/generated/l10n.dart';

class HerbaryScreen extends StatefulWidget {
  const HerbaryScreen({Key? key}) : super(key: key);

  @override
  _HerbaryScreenState createState() => _HerbaryScreenState();
}

class _HerbaryScreenState extends State<HerbaryScreen>
    with AutomaticKeepAliveClientMixin {
  HerbaryScreenController controller = Get.find();

  @override
  void initState() {
    super.initState();
    print(controller.plants);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final delegate = S.of(context);
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          InkWell(
            onDoubleTap: () => PlantsDatabase.instance.deleteDB('plants.db'),
            onLongPress: () => controller.discoverPlant(6),
            child: Text(
              delegate.herbaryScreenTitle,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              children: controller.plants!
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                                e.discovered ? NetworkImage(e.urlImage) : null,
                            backgroundColor: Colors.white.withOpacity(0.5),
                            child: !e.discovered
                                ? Center(
                                    child: Text("?",
                                        style: TextStyle(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                                .withOpacity(0.75))),
                                  )
                                : null,
                          ),
                        ),
                      ))
                  .toList()
                    ..addAll([
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

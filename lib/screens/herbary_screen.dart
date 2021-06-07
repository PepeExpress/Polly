import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/herbary_screen_controller.dart';
import 'package:plant_classification/db/plants_database.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/utils/globals.dart';
import 'package:plant_classification/widgets/grid_plant_element.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final delegate = S.of(context);
    final rnd = new Random();
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          GestureDetector(
            onDoubleTap: () => PlantsDatabase.instance.deleteDB('plants.db'),
            onLongPress: () => controller.discoverPlant(rnd.nextInt(40)),
            child: Text(
              delegate.herbaryScreenTitle,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Obx(
            () => CircularPercentIndicator(
                radius: 100,
                lineWidth: 10,
                curve: Curves.fastOutSlowIn,
                progressColor: Colors.black.withOpacity(0.5),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.white.withOpacity(0.5),
                rotateLinearGradient: true,
                percent: controller.percentageFound.value,
                animation: true,
                animateFromLastPercent: true,
                center: Text(
                  (controller.percentageFound.value * 100).toInt().toString() +
                      "%",
                  style: Theme.of(context).textTheme.bodyText1,
                )),
          ),
          GestureDetector(
            onDoubleTap: () => controller.discoverAll(),
            onLongPress: () => controller.undiscoverAll(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() => Text(
                        "Trovati " +
                            (controller.percentageFound.value * 40)
                                .toInt()
                                .toString(),
                        style: Theme.of(context).textTheme.headline3,
                      )),
                  Obx(() => Text(
                        "Mancanti " +
                            (40 - controller.percentageFound.value * 40)
                                .toInt()
                                .toString(),
                        style: Theme.of(context).textTheme.headline3,
                      )),
                ],
              ),
            ),
          ),
          Flexible(
            child: GetX<HerbaryScreenController>(builder: (controller) {
              return GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                children: controller.plants!
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridPlantElement(
                            plant: e,
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
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

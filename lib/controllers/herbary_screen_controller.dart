import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plant_classification/controllers/firestore_controller.dart';
import 'package:plant_classification/db/badges_database.dart';
import 'package:plant_classification/db/plants_database.dart';
import 'package:plant_classification/model/badges.dart';
import 'package:plant_classification/model/plants.dart';
import 'package:plant_classification/model/quotes.dart';
import 'package:plant_classification/model/user.dart';
import 'package:plant_classification/utils/auth/authentication_controller.dart';

class HerbaryScreenController extends GetxController {
  HerbaryScreenController(
      List<Plant> plants, List<Quote> quotes, List<Badge> badges) {
    this.plants = RxList(plants);
    this.quotes = RxList(quotes);
    this.badges = RxList(badges);
    this.percentageFound.value = calculatePercentageFound();
    print(getDiscoveredBadges());
  }
  RxList<Quote>? quotes;
  RxList<Plant>? plants;
  RxList<Badge>? badges;
  RxDouble percentageFound = 0.0.obs;
  final storage = GetStorage();
  FirestoreDB fire = Get.find();
  AuthenticationController ac = Get.find();

  Future discoverPlant(int id) async {
    if (id >= 0) {
      if (!plants![id].discovered) {
        _checkBadges();
        var updatedPlant = plants![id].copy(
          discovered: true,
          discoveredTime: DateTime.now(),
        );
        PlantsDatabase.instance.update(updatedPlant);
        plants![id] = updatedPlant;
        awardPoints(50);
      } else {
        awardPoints(10);
      }
    }
    this.percentageFound.value = calculatePercentageFound();
  }

  Future undiscoverPlant(int id) async {
    if (id >= 0) {
      if (plants![id].discovered) {
        var updatedPlant = plants![id].copy(
            discovered: false,
            discoveredTime: DateTime.fromMillisecondsSinceEpoch(0));
        PlantsDatabase.instance.update(updatedPlant);
        plants![id] = updatedPlant;
      }
    }
    this.percentageFound.value = calculatePercentageFound();
  }

  void awardPoints(int points) {
    storage.write('points', storage.read('points') + points);
    ac.modelUser(ModelUser(
        username: ac.modelUser.value.username,
        imgIndex: ac.modelUser.value.imgIndex,
        uid: ac.modelUser.value.uid,
        points: storage.read('points')));
    fire.updatePoints(ac.modelUser.value);
  }

  Future discoverAll() async {
    plants!.forEach((element) {
      discoverPlant(element.id! - 1);
    });
  }

  String getRandomQuote() {
    Random rnd = Random();
    return quotes![rnd.nextInt(quotes!.length)].quote;
  }

  Future undiscoverAll() async {
    plants!.forEach((element) {
      undiscoverPlant(element.id! - 1);
    });
  }

  Future resetBadges() async {
    BadgesDatabase.instance.deleteDB('badges');
  }

  double calculatePercentageFound() {
    print("PERCENTAGE " +
        (plants!.where((element) => element.discovered).length / 40)
            .toString());
    return plants!.where((element) => element.discovered).length / 40;
  }

  Future<List<Plant>> getLastPlantsDiscovered() async {
    var tempResult = plants!.where((plant) => plant.discovered).toList();
    tempResult.sort((a, b) => b.discoveredTime.compareTo(a.discoveredTime));
    return tempResult.take(3).toList();
  }

  List<Badge> getDiscoveredBadges() {
    return badges!.where((badge) => badge.discovered).toList();
  }

  void _checkBadges() {
    _checkFirstPlantBadge();
    _checkThreePlantsInADayBadge();
    _checkHalfPercentFound();
  }

  void _checkFirstPlantBadge() {
    if (percentageFound.value == 0.0) {
      var updatedBadge = badges![0].copy(
        discovered: true,
        discoveredTime: DateTime.now(),
      );
      BadgesDatabase.instance.update(updatedBadge);
      badges![0] = updatedBadge;
    }
  }

  void _checkThreePlantsInADayBadge() {
    var currentDate = DateTime.now();
    if (!badges![1].discovered) {
      if (plants!
              .where((plant) =>
                  plant.discoveredTime.day == currentDate.day &&
                  plant.discoveredTime.month == currentDate.month &&
                  plant.discoveredTime.year == currentDate.year)
              .toList()
              .length >=
          2) {
        var updatedBadge = badges![1].copy(
          discovered: true,
          discoveredTime: currentDate,
        );
        BadgesDatabase.instance.update(updatedBadge);
        badges![1] = updatedBadge;
      }
    }
  }

  void _checkHalfPercentFound() {
    if (!badges![2].discovered) {
      if (percentageFound >= 0.5) {
        var updatedBadge = badges![2].copy(
          discovered: true,
          discoveredTime: DateTime.now(),
        );
        BadgesDatabase.instance.update(updatedBadge);
        badges![2] = updatedBadge;
      }
    }
  }
}

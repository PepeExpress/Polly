import 'package:get/get.dart';
import 'package:plant_classification/db/plants_database.dart';
import 'package:plant_classification/model/plants.dart';

class HerbaryScreenController extends GetxController {
  HerbaryScreenController(List<Plant> plants) {
    this.plants = RxList(plants);
    this.percentageFound.value = calculatePercentageFound();
  }

  RxList<Plant>? plants;
  RxDouble percentageFound = 0.0.obs;

  Future discoverPlant(int id) async {
    if (id >= 0) {
      if (!plants![id].discovered) {
        var updatedPlant = plants![id].copy(
          discovered: true,
          discoveredTime: DateTime.now(),
        );
        PlantsDatabase.instance.update(updatedPlant);
        plants![id] = updatedPlant;
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

  Future discoverAll() async {
    plants!.forEach((element) {
      discoverPlant(element.id! - 1);
    });
  }

  Future undiscoverAll() async {
    plants!.forEach((element) {
      undiscoverPlant(element.id! - 1);
    });
  }

  double calculatePercentageFound() {
    print("PERCENTAGE " +
        (plants!.where((element) => element.discovered).length / 40)
            .toString());
    return plants!.where((element) => element.discovered).length / 40;
  }
}

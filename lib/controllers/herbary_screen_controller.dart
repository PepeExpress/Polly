import 'package:get/get.dart';
import 'package:plant_classification/db/plants_database.dart';
import 'package:plant_classification/model/plants.dart';

class HerbaryScreenController extends GetxController {
  HerbaryScreenController(List<Plant> plants) {
    this.plants = RxList(plants);
  }
  RxList<Plant>? plants;

  Future discoverPlant(int id) async {
    if (id >= 0) {
      if (!plants![id].discovered) {
        var updatedPlant =
            plants![id].copy(discovered: true, discoveredTime: DateTime.now());
        PlantsDatabase.instance.update(updatedPlant);
        plants![id] = updatedPlant;
      }
    }
  }
}

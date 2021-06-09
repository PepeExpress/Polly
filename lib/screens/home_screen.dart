import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_classification/controllers/herbary_screen_controller.dart';
import 'package:plant_classification/generated/l10n.dart';
import 'package:plant_classification/model/plants.dart';
import 'package:plant_classification/widgets/list_plant_entry.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  HerbaryScreenController hc = Get.find();
  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text(
              delegate.homeScreenTitle,
              style: Theme.of(context).textTheme.headline1,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Lo sapevi che...",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0xFFFFFFFF).withOpacity(0.3),
                        spreadRadius: 5,
                        offset: Offset(5, 0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    hc.getRandomQuote(),
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Scoperte recenti",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: hc.getLastPlantsDiscovered(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Plant>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 32, right: 32),
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/camera'),
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sembra che tu non abbia ancora collezionato nessuna pianta, clicca qui per trovarne una",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      textAlign: TextAlign.center,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/camera'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        height: 300,
                        child: Center(
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, i) {
                              return SizedBox(
                                width: 20,
                              );
                            },
                            itemBuilder: (context, i) {
                              return ListPlantEntry(
                                plant: snapshot.data![i],
                              );
                            },
                            itemCount: snapshot.data!.length,
                          ),
                        ),
                      );
                    }
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}

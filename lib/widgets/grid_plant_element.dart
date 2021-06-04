import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_classification/model/plants.dart';
import 'package:plant_classification/screens/detail_screen.dart';

class GridPlantElement extends StatelessWidget {
  const GridPlantElement({Key? key, required this.plant}) : super(key: key);
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
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
      child: !plant.discovered
          ? Center(
              child: Text("?",
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.75))),
            )
          : Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: DetailScreenArguments(plant),
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: plant.urlImage,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Hero(
                    tag: 'picture' + plant.id.toString(),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

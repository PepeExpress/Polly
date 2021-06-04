import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_classification/model/plants.dart';
import 'package:plant_classification/utils/date_formatter.dart';
import 'package:plant_classification/utils/wikipedia_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as DetailScreenArguments;
    final WikipediaInfo info = WikipediaInfo(args.plant.urlWikipedia);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            floating: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: CachedNetworkImage(
              color: Colors.transparent,
              imageUrl: args.plant.urlImage,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Hero(
                tag: 'picture' + args.plant.id.toString(),
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    args.plant.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    "Trovato per la prima volta " +
                        date(args.plant.discoveredTime)!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Descrizione",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    args.plant.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continua su ",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.wikipediaW),
                        onPressed: () => _launchURL(args.plant.urlWikipedia),
                      )
                    ],
                  )
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class DetailScreenArguments {
  final Plant plant;

  DetailScreenArguments(this.plant);
}

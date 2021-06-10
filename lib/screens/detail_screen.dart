import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plant_classification/model/plants.dart';
import 'package:plant_classification/model/user.dart';
import 'package:plant_classification/utils/auth/authentication_controller.dart';
import 'package:plant_classification/utils/date_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final DetailScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as DetailScreenArguments;
    final AuthenticationController ac = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            floating: true,
            actions: [
              IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () {
                  if (storage.read('usrImage') != null) {
                    storage.write('usrImage', args.plant.id! - 1);
                    ac.modelUser(ModelUser(
                        username: ac.modelUser.value.username,
                        uid: ac.modelUser.value.uid,
                        imgIndex: args.plant.id! - 1,
                        points: ac.modelUser.value.points));
                    Flushbar(
                      message: "Immagine del profilo cambiata con successo!",
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
              )
            ],
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

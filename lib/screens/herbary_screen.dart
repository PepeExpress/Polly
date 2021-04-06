import 'package:flutter/material.dart';
import 'package:plant_classification/generated/l10n.dart';

class HerbaryScreen extends StatefulWidget {
  const HerbaryScreen({Key key}) : super(key: key);

  @override
  _HerbaryScreenState createState() => _HerbaryScreenState();
}

class _HerbaryScreenState extends State<HerbaryScreen>
    with AutomaticKeepAliveClientMixin {
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
    final delegate = S.of(context);
    return Column(
      children: [
        SafeArea(
          child: Text(
            delegate.herbaryScreenTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              GridView.count(
                padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                crossAxisCount: 3,
                children: List.generate(40, (index) {
                  return Container(
                    child: Card(
                      color: Colors.amber,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

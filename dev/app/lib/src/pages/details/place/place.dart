import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';
import 'package:app/src/objects/place.dart';
import 'body.dart';

class PlaceDetail extends StatefulWidget {
  Place place;
  PlaceDetail({
    Key key,
    this.place,
  }) : super(key: key);

  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<PlaceDetail> {
  bool theme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return Scaffold(
      backgroundColor: (!theme)
          ? LightPalette().colors["${Palette.backgroundSecondary}"]
          : DarkPalette().colors["${Palette.backgroundSecondary}"],
      body: Stack(
        children: [
          Body(
            place: widget.place,
          ),
        ],
      ),
    );
  }
}

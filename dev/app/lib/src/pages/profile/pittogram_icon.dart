import 'package:app/src/design_system/palette.dart';
import 'package:app/src/enums/pittograms.dart';
import 'package:flutter/material.dart';

class PittogramIcon extends StatelessWidget {
  final String img;
  const PittogramIcon({Key key, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: (MediaQuery.of(context).platformBrightness == Brightness.dark)
              ? DarkPalette().colors["Palette.backgroundSecondary"]
              : LightPalette().colors["Palette.backgroundSecondary"],
        ),
        child: Image.asset('$img'));
  }
}

import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';

class PittogramIcon extends StatelessWidget {
  final String img;
  const PittogramIcon({Key key, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 64,
        height: 64,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: (MediaQuery.of(context).platformBrightness == Brightness.dark)
              ? DarkPalette().colors["Palette.white"].withOpacity(0.4)
              : LightPalette().colors["Palette.black"].withOpacity(0.4),
        ),
        padding: const EdgeInsets.all(12),
        child: Image.asset('assets/pittograms/$img'));
  }
}

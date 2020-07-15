import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';
import './body.dart';

class Norms extends StatelessWidget {
  const Norms({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          (MediaQuery.of(context).platformBrightness == Brightness.dark)
              ? DarkPalette().colors["Palette.backgroundPrimary"]
              : LightPalette().colors["Palette.backgroundPrimary"],
      body: Body(),
    );
  }
}

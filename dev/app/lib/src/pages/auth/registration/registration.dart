import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';
import './confirm/confirm.dart';

class Registration extends StatelessWidget {
  final Widget child;
  const Registration({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          (MediaQuery.of(context).platformBrightness == Brightness.dark)
              ? DarkPalette().colors["${Palette.backgroundPrimary}"]
              : LightPalette().colors["${Palette.backgroundPrimary}"],
      body: child,
    );
  }
}

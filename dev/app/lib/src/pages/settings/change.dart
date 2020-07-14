import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';

class Change extends StatefulWidget {
  Widget child;
  Change({Key key, @required this.child}) : super(key: key);

  @override
  _ChangeState createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          (MediaQuery.of(context).platformBrightness == Brightness.dark)
              ? DarkPalette().colors["Palette.backgroundPrimary"]
              : LightPalette().colors["Palette.backgroundPrimary"],
      body: widget.child,
    );
  }
}

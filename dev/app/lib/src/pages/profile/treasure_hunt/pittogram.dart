import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/enums/pittograms.dart';
import 'package:app/src/pages/profile/pittogram_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Pittogram extends StatefulWidget {
  Pittogram({Key key}) : super(key: key);

  @override
  _PittogramsState createState() => _PittogramsState();
}

class _PittogramsState extends State<Pittogram> {
  double opacity = 0.0;
  bool isTapped = false;
  bool theme;

  @override
  Widget build(BuildContext context) {
    if (isTapped)
      opacity = 0.9;
    else
      opacity = 1;

    setState(() {
      theme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    });

    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) => toogleTappedFlag(),
          onTapCancel: () => cancelTappedFlag(),
          onTapUp: (TapUpDetails details) => cancelTappedFlag(),
          onTap: () {
            Navigator.pushNamed(context, '/TreasureHunt');
          },
          child: AnimatedContainer(
            margin: const EdgeInsets.only(top: 0, bottom: 0),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
              color: (!theme)
                  ? LightPalette().colors["Palette.backgroundSecondary"]
                  : DarkPalette().colors["Palette.backgroundSecondary"],
              borderRadius: BorderRadius.circular(16),
            ),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PittogramIcon(
                  img: PittogramsImages().colosseo,
                ),
                Container(
                  child: Wrap(
                    children: [
                      CText(
                        'Colosseo',
                        size: 22,
                        left: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  toogleTappedFlag() {
    setState(() {
      isTapped = true;
    });
  }

  cancelTappedFlag() {
    setState(() {
      isTapped = false;
    });
  }
}

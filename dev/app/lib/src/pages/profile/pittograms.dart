import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/enums/pittograms.dart';
import 'package:app/src/pages/profile/pittogram_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Pittograms extends StatefulWidget {
  Pittograms({Key key}) : super(key: key);

  @override
  _PittogramsState createState() => _PittogramsState();
}

class _PittogramsState extends State<Pittograms> {
  double opacity = 0.0;
  bool isTapped = false;
  bool theme;

  @override
  Widget build(BuildContext context) {
    if (isTapped)
      opacity = 0.5;
    else
      opacity = 1;

    setState(() {
      theme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    });

    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: Container(
        child: GestureDetector(
          onTapDown: (TapDownDetails details) => toogleTappedFlag(),
          onTapCancel: () => cancelTappedFlag(),
          onTapUp: (TapUpDetails details) => cancelTappedFlag(),
          onTap: () {},
          child: AnimatedContainer(
              margin: const EdgeInsets.only(top: 24, bottom: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: (!theme)
                    ? LightPalette().colors["Palette.backgroundSecondary"]
                    : DarkPalette().colors["Palette.backgroundSecondary"],
                /*boxShadow: [
                BoxShadow(
                  color: (isTapped)
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.1),
                  blurRadius: (isTapped) ? 0 : 8,
                  offset: Offset(0, -2),
                ),
                BoxShadow(
                  color: (isTapped)
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.1),
                  blurRadius: (isTapped) ? 0 : 8,
                  offset: Offset(0, 2),
                ),
              ],*/
                borderRadius: BorderRadius.circular(16),
              ),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              child: Column(
                children: [
                  Row(
                    children: [
                      PittogramIcon(img: PittogramsImages().colosseo),
                      PittogramIcon(img: PittogramsImages().domusAurea),
                      PittogramIcon(img: PittogramsImages().foroRomano),
                      PittogramIcon(img: PittogramsImages().palatino),
                    ],
                  ),
                ],
              )),
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

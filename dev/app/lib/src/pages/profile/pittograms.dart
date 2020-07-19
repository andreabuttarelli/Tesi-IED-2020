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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) => toogleTappedFlag(),
          onTapCancel: () => cancelTappedFlag(),
          onTapUp: (TapUpDetails details) => cancelTappedFlag(),
          onTap: () {
            Navigator.pushNamed(context, '/TreasureHunt');
          },
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    PittogramIcon(img: PittogramsImages().colosseo),
                    PittogramIcon(img: PittogramsImages().domusAurea),
                    PittogramIcon(img: PittogramsImages().foroRomano),
                    PittogramIcon(img: PittogramsImages().palatino),
                  ],
                ),
                CText(
                  'Adesso tocca a te lasciare il segno.',
                  size: 24,
                  weight: FontWeight.bold,
                  color: Palette.textPrimary,
                  top: 24,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: (theme)
                        ? DarkPalette().colors["Palette.white"].withOpacity(0.2)
                        : LightPalette()
                            .colors["Palette.black"]
                            .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        'Token trovati:',
                        size: 20,
                        weight: FontWeight.w600,
                        color: Palette.textSecondary70,
                        top: 3,
                      ),
                      CText(
                        '0',
                        size: 20,
                        weight: FontWeight.bold,
                        color: Palette.textPrimary,
                        top: 3,
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

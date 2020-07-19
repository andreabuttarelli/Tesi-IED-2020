import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/profile/treasure_hunt/pittogram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool theme;
  bool isPulled = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFF0ABAB5),
        Color(0xFF4BC47C),
      ])),
      child: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        animSpeedFactor: 4,
        color: (!theme)
            ? LightPalette().colors["Palette.textPrimary"]
            : DarkPalette().colors["Palette.textPrimary"],
        height: 100,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
          },
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TopIconBack(
                      icon: FeatherIcons.arrowLeft,
                      color: (!theme)
                          ? LightPalette().colors["Palette.textPrimary"]
                          : DarkPalette().colors["Palette.textPrimary"],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: (!theme)
                      ? LightPalette().colors['${Palette.backgroundSecondary}']
                      : DarkPalette().colors['${Palette.backgroundSecondary}'],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Wrap(
                  children: [
                    CText(
                      'Adesso tocca a te lasciare il segno',
                      size: 32,
                      weight: FontWeight.bold,
                      top: 8,
                      bottom: 0,
                    ),
                    CText(
                      '',
                      size: 32,
                      weight: FontWeight.bold,
                      top: 8,
                      bottom: 0,
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: (!theme)
                      ? LightPalette().colors['${Palette.backgroundSecondary}']
                      : DarkPalette().colors['${Palette.backgroundSecondary}'],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Wrap(
                  children: [
                    Pittogram(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isPulled = true;
    });
  }
}

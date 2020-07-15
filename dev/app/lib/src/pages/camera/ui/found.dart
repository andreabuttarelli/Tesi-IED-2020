import 'dart:ui';

import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Found extends StatelessWidget {
  const Found({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopIconBack(
                    icon: FeatherIcons.x,
                    color: Colors.white,
                  ),
                  TopIcon(
                    icon: FeatherIcons.helpCircle,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CText(
                    'Detected!',
                    size: 32,
                    weight: FontWeight.bold,
                    color: Palette.white,
                    hPadding: 24,
                    top: 24,
                    bottom: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
        Center(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

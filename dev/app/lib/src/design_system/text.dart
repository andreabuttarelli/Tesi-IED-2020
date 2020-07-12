import 'package:app/src/blocs/accessibility/index.dart';
import 'package:app/src/blocs/theme/index.dart';
import 'package:app/src/design_system/palette.dart';

/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CText extends StatelessWidget {
  final String value;
  final double size;
  final PaletteColor color;
  final FontWeight weight;
  final double hPadding;
  final double vPadding;
  final double top, bottom, left, right;
  const CText(
    @required this.value, {
    Key key,
    this.size,
    this.weight,
    this.color,
    this.hPadding,
    this.vPadding,
    this.top,
    this.bottom,
    this.left,
    this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String family;
    double letterSpacing;
    double height;
    if (weight == FontWeight.w300) {
      family = "Gilroy";
      letterSpacing = 0;
    } else if (weight == FontWeight.w400) {
      family = "GilroyRegular";
      letterSpacing = -0.3;
    } else if (weight == FontWeight.w500) {
      family = "GilroyMedium";
      letterSpacing = -1.3;
    } else if (weight == FontWeight.w700) {
      family = "GilroyBold";
      letterSpacing = -1.3;
      height = size + 0;
    } else if (weight == FontWeight.w800) {
      family = "Gilroy";
      letterSpacing = 0;
    } else {
      family = "GilroyMedium";
      letterSpacing = -1.3;
    }

    return BlocBuilder<AccessibilityBloc, bool>(
      builder: (context, isAccessible) {
        double accessibleOffset = 1;
        if (isAccessible) accessibleOffset = 1.2;
        return Container(
          margin: EdgeInsets.only(
            top: (top == null) ? 0 : top,
            bottom: (bottom == null) ? 0 : bottom,
            left: (left == null) ? 0 : left,
            right: (right == null) ? 0 : right,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: (hPadding == null) ? 0 : hPadding,
            vertical: (vPadding == null) ? 0 : vPadding,
          ),
          child: BlocBuilder<ThemeBloc, ThemeEnum>(
            builder: (context, theme) {
              return Text(
                '$value',
                style: TextStyle(
                  color: color.color ?? (theme == ThemeEnum.dark)
                      ? Colors.white
                      : Colors.black,
                  fontSize: (size != null)
                      ? (size * accessibleOffset)
                      : (16 * accessibleOffset),
                  fontWeight: weight ?? FontWeight.w500,
                  fontFamily: family,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

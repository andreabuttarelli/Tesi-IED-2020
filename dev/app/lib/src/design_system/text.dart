import 'package:app/src/blocs/accessibility/index.dart';
import 'package:app/src/blocs/theme/index.dart';
import 'package:app/src/design_system/palette.dart';

/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CText extends StatefulWidget {
  final String value;
  final double size;
  final Palette color;
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
  _CTextState createState() => _CTextState();
}

class _CTextState extends State<CText> {
  String family;
  double letterSpacing;
  double height;
  Color finalColor;
  bool theme;

  @override
  void initState() {
    if (widget.weight == FontWeight.w300) {
      family = "Gilroy";
      letterSpacing = 0;
    } else if (widget.weight == FontWeight.w400) {
      family = "GilroyRegular";
      letterSpacing = -0.3;
    } else if (widget.weight == FontWeight.w500) {
      family = "GilroyMedium";
      letterSpacing = -1.3;
    } else if (widget.weight == FontWeight.w700) {
      family = "GilroyBold";
      letterSpacing = -1.3;
      height = widget.size + 0;
    } else if (widget.weight == FontWeight.w800) {
      family = "Gilroy";
      letterSpacing = 0;
    } else {
      family = "GilroyMedium";
      letterSpacing = -1.3;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    });

    if (MediaQuery.of(context).platformBrightness == Brightness.dark)
      finalColor = DarkPalette().colors["${widget.color}"];
    else
      finalColor = LightPalette().colors["${widget.color}"];

    print('theme: $theme, color: ${widget.color}, finalColor: $finalColor');
    return BlocBuilder<AccessibilityBloc, bool>(
      builder: (context, isAccessible) {
        double accessibleOffset = 1;
        if (isAccessible) accessibleOffset = 1.2;
        return Container(
          margin: EdgeInsets.only(
            top: (widget.top == null) ? 0 : widget.top,
            bottom: (widget.bottom == null) ? 0 : widget.bottom,
            left: (widget.left == null) ? 0 : widget.left,
            right: (widget.right == null) ? 0 : widget.right,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: (widget.hPadding == null) ? 0 : widget.hPadding,
            vertical: (widget.vPadding == null) ? 0 : widget.vPadding,
          ),
          child: Text(
            '${widget.value}',
            style: TextStyle(
              color: (finalColor != null)
                  ? finalColor
                  : (!theme)
                      ? LightPalette().colors["${widget.color}"]
                      : DarkPalette().colors["${widget.color}"],
              fontSize: (widget.size != null)
                  ? (widget.size * accessibleOffset)
                  : (16 * accessibleOffset),
              fontWeight: widget.weight ?? FontWeight.w500,
              fontFamily: family,
            ),
          ),
        );
      },
    );
  }
}

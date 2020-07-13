import 'package:app/src/blocs/theme/index.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Button extends StatefulWidget {
  final String label;
  final Palette color;
  final ButtonType type;
  final ButtonDims dims;
  final Function onClick;
  Button({
    Key key,
    this.label,
    this.color,
    this.type,
    this.dims,
    this.onClick,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isTapped = false;
  double hPadding = 0;
  double width;
  double height;
  Color color;
  BoxDecoration decoration;
  double opacity;

  @override
  void initState() {
    if (widget.dims == ButtonDims.large) {
      hPadding = 24;
      height = 54;
    } else if (widget.dims == ButtonDims.medium) {
      height = 54;
      width = 200;
    } else
      hPadding = 8;

    bool theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);

    if (widget.type == ButtonType.primarySolid ||
        widget.type == ButtonType.primaryStroke)
      color = (!theme)
          ? LightPalette().colors["textPrimary"]
          : DarkPalette().colors["textPrimary"];
    else if (widget.type == ButtonType.secondarySolid ||
        widget.type == ButtonType.secondaryStroke)
      color = LightPalette().colors["accent"];
    else if (widget.type == ButtonType.thirdSolid ||
        widget.type == ButtonType.thirdStroke)
      color = (!theme)
          ? LightPalette().colors["textPrimaryInverse"]
          : DarkPalette().colors["textPrimaryInverse"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isTapped)
      opacity = 0.5;
    else
      opacity = 1;

    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 8),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) => toogleTappedFlag(),
          onTapCancel: () => cancelTappedFlag(),
          onTapUp: (TapUpDetails details) => cancelTappedFlag(),
          onTap: () => widget.onClick(),
          child: AnimatedContainer(
            width: width,
            height: height,
            decoration: (widget.type == ButtonType.primarySolid ||
                    widget.type == ButtonType.secondarySolid ||
                    widget.type == ButtonType.thirdSolid ||
                    widget.type == null)
                ? BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: color,
                      width: 2,
                    ),
                  )
                : BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: color,
                      width: 2,
                    ),
                  ),
            child: Center(
              child: CText(
                '${widget.label}',
                size: 18,
                color: (widget.type == ButtonType.primaryStroke ||
                        widget.type == ButtonType.secondaryStroke ||
                        widget.type == ButtonType.thirdSolid)
                    ? Palette.textPrimary
                    : Palette.textPrimaryInverse,
                weight: FontWeight.w800,
              ),
            ),
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
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

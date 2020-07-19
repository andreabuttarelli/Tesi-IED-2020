import 'package:app/src/blocs/accessibility/bloc.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopIcon extends StatefulWidget {
  Color color;
  IconData icon;
  final Function onClick;
  TopIcon({Key key, this.color, @required this.icon, this.onClick})
      : super(key: key);

  @override
  _TopIconState createState() => _TopIconState();
}

class _TopIconState extends State<TopIcon> {
  bool isTapped = false;
  double opacity;

  @override
  Widget build(BuildContext context) {
    if (isTapped)
      opacity = 0.5;
    else
      opacity = 1;

    return BlocBuilder<AccessibilityBloc, bool>(
      builder: (context, isAccessible) {
        return Opacity(
          opacity: opacity,
          child: Container(
            padding: EdgeInsets.only(top: 16, left: 16, bottom: 16, right: 16),
            child: GestureDetector(
              onTapDown: (detail) => toogleTappedFlag(),
              onTapCancel: () => cancelTappedFlag(),
              onTapUp: (TapUpDetails details) => cancelTappedFlag(),
              onTap: () => widget.onClick(),
              child: Container(
                child: Icon(
                  widget.icon,
                  size: (isAccessible) ? 24 * 1.2 : 24,
                  color: (widget.color != null)
                      ? widget.color
                      : (MediaQuery.of(context).platformBrightness ==
                              Brightness.dark)
                          ? DarkPalette().colors["${Palette.textPrimary}"]
                          : LightPalette().colors["${Palette.textPrimary}"],
                ),
              ),
            ),
          ),
        );
      },
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

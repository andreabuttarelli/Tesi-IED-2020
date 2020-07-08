import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Option extends StatefulWidget {
  final String label;
  final Function onClick;
  final Color color;
  bool withIcon = true;
  final double fontSize;
  final IconData icon;
  Option({
    Key key,
    this.label,
    this.onClick,
    this.color,
    this.withIcon,
    this.fontSize,
    this.icon,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Option> {
  bool isTapped = false;
  double hPadding = 0;
  double width;
  double height;
  Color color;
  BoxDecoration decoration;
  double opacity;

  @override
  void initState() {
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
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) => toogleTappedFlag(),
          onTapCancel: () => cancelTappedFlag(),
          onTapUp: (TapUpDetails details) => cancelTappedFlag(),
          onTap: () => widget.onClick(),
          child: AnimatedContainer(
            width: width,
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CText(
                  '${widget.label}',
                  size: widget.fontSize ?? 24,
                  color: widget.color,
                  weight: FontWeight.w800,
                ),
                (widget.withIcon != null)
                    ? (widget.withIcon)
                        ? Icon(
                            (widget.icon != null)
                                ? widget.icon
                                : FeatherIcons.chevronRight,
                            size: 24,
                            color: widget.color,
                          )
                        : Container()
                    : Icon(
                        (widget.icon != null)
                            ? widget.icon
                            : FeatherIcons.chevronRight,
                        size: 24,
                        color: widget.color,
                      ),
              ],
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

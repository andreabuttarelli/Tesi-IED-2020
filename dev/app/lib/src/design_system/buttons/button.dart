import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String label;
  final Color color;
  final ButtonType type;
  final ButtonDims dims;
  Button({
    Key key,
    this.label,
    this.color,
    this.type,
    this.dims,
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

    if (widget.color != null)
      color = widget.color;
    else if (widget.type == ButtonType.primarySolid ||
        widget.type == ButtonType.primaryStroke)
      color = Colors.black;
    else if (widget.type == ButtonType.secondarySolid ||
        widget.type == ButtonType.secondaryStroke) color = Color(0xFFA92217);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isTapped) 
      opacity = 0.5;
    else
      opacity = 1;

    return Opacity(
      opacity: opacity,
      child:Container(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 8),
      child: GestureDetector(
        onTapDown: (TapDownDetails details) => toogleTappedFlag(),
        onTapCancel: () => cancelTappedFlag(),
        onTapUp: (TapUpDetails details) => cancelTappedFlag(),
        child: AnimatedContainer(
          width: width,
          height: height,
          decoration: (widget.type == ButtonType.primarySolid ||
                  widget.type == ButtonType.secondarySolid ||
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
                      widget.type == ButtonType.secondaryStroke)
                  ? Colors.black
                  : Colors.white,
              weight: FontWeight.w800,
            ),
          ),
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
        ),
      ),
    ),);
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

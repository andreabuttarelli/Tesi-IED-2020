import 'package:flutter/material.dart';

class TopIcon extends StatefulWidget {
  Color color;
  IconData icon;
  TopIcon({Key key, this.color, @required this.icon}) : super(key: key);

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

    return Opacity(
      opacity: opacity,
      child: Container(
        padding: EdgeInsets.only(top: 24, left: 24, bottom: 16, right: 16),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) => toogleTappedFlag(),
          onTapCancel: () => cancelTappedFlag(),
          onTapUp: (TapUpDetails details) => cancelTappedFlag(),
          child: Container(
            child: Icon(
              widget.icon,
              size: 24,
              color: widget.color,
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

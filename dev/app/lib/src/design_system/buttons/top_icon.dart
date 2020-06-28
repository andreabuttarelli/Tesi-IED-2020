import 'package:flutter/material.dart';

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

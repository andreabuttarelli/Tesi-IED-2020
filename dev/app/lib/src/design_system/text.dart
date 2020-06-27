/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020

import 'package:flutter/material.dart';

class CText extends StatelessWidget {
  final String value;
  final double size;
  final Color color;
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
      child: Text(
        '$value',
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: size ?? 16,
          fontWeight: weight ?? FontWeight.w500,
        ),
      ),
    );
  }
}

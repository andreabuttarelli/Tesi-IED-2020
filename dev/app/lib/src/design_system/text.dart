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
  const CText(@required this.value, {Key key, this.size, this.weight, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$value',
      style: TextStyle(color: color ?? Colors.black, fontSize: size ?? 16, fontWeight: weight ?? FontWeight.w500,),
    );
  }
}
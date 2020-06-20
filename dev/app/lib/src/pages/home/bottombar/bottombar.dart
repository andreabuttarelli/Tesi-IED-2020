/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/src/blocs/navigation/index.dart';
import 'package:app/src/pages/home/bottombar/body.dart';

class BottomBar extends StatelessWidget {
  final Color color, bgColor;
  final List<BottomAppBarItem> items;
  const BottomBar({
    Key key,
    this.items,
    this.color,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomBarBody(items: items, color: color, backgroundColor: bgColor,);
  }
}

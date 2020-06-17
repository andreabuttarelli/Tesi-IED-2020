/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020

import 'package:flutter/material.dart';
import './body.dart';
import './header.dart';

class Notes extends StatelessWidget {
  const Notes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Header(),
          Body(),
        ],
      ),
    );
  }
}
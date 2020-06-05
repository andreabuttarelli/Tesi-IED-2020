/// MIT License
/// by Andrea Buttarelli
/// creato il 05/06/2020
/// aggiornato il 05/06/2020

import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Text('Feed'),
          ),
        ],
      ),
    );
  }
}

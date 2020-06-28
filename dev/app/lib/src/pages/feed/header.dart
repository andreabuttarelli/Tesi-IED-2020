import 'package:app/src/design_system/text.dart';

/// MIT License
/// by Andrea Buttarelli
/// creato il 05/06/2020
/// aggiornato il 05/06/2020

import 'package:flutter/material.dart';
import './norms.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CText(
                'News',
                size: 48,
                weight: FontWeight.w700,
              ),
            ),
            Wrap(
              children: [
                CText(
                  'Tutte le ultime notizie, per te.',
                  size: 20,
                  weight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.7),
                ),
                NormsWidget(
                  onClick: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

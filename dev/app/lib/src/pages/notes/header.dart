import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/buttons/user_picture_button.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 64,
                  child: (MediaQuery.of(context).platformBrightness ==
                          Brightness.dark)
                      ? Image.asset('assets/img/logo.png')
                      : Image.asset('assets/img/logo.jpeg'),
                ),
                UserProfileButton(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              child: CText(
                'Prendi nota',
                size: 48,
                weight: FontWeight.w700,
              ),
            ),
            Wrap(
              children: [
                CText(
                  'Perchè non è sempre possibile ricordarsi tutto.',
                  size: 20,
                  weight: FontWeight.w700,
                  color: Palette.textSecondary70,
                  bottom: 24,
                ),
              ],
            ),
            Button(
              label: 'New Note',
              color: Palette.accent,
              type: ButtonType.secondarySolid,
              dims: ButtonDims.medium,
              onClick: () {
                Navigator.pushNamed(context, "/NewNote");
              },
            ),
          ],
        ),
      ),
    );
  }
}

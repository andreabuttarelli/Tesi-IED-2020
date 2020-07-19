import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Header extends StatefulWidget {
  Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool theme;

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopIconBack(
                  icon: FeatherIcons.arrowLeft,
                  color: (!theme)
                      ? LightPalette().colors["Palette.textPrimary"]
                      : DarkPalette().colors["Palette.textPrimary"],
                ),
              ],
            ),
          ),
          Container(
            child: Wrap(
              children: [
                CText(
                  'Su cosa vorresti prendere appunti?',
                  size: 32,
                  weight: FontWeight.w500,
                  hPadding: 24,
                  top: 8,
                  bottom: 24,
                ),
              ],
            ),
          ),
          CTextField(
            title: 'Cerca qui',
            placeholder: 'Cerca il nome',
          ),
        ],
      ),
    );
  }
}

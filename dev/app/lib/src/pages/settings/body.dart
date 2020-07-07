import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: TopIconBack(
                  icon: FeatherIcons.arrowLeft,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          CText(
            'Settings',
            size: 32,
            weight: FontWeight.bold,
            hPadding: 24,
            top: 8,
            bottom: 24,
          ),
        ],
      ),
    );
  }
}

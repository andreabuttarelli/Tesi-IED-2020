import 'package:app/src/blocs/user/index.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/objects/user.dart';
import 'package:app/src/pages/settings/settings.dart';

/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 04/07/2020

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        padding: const EdgeInsets.all(0),
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopIconBack(
                  icon: FeatherIcons.arrowLeft,
                  color: Colors.black,
                ),
                TopIcon(
                  icon: FeatherIcons.settings,
                  color: Colors.black,
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Settings()),
                    );
                  },
                ),
              ],
            ),
          ),
          CText(
            'Profile',
            size: 32,
            weight: FontWeight.bold,
            hPadding: 24,
            top: 8,
            bottom: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              color: Color(0xFFF1F1F1),
              child: BlocBuilder<UserBloc, UserObject>(
                builder: (context, user) {
                  if (user != null) {
                    if (user is UserObject) {
                      return Column(
                        children: [],
                      );
                    }
                  }
                  return Center(
                    child: CText(
                      'Sorry, something went wrong',
                      size: 16,
                      color: Colors.black,
                      weight: FontWeight.normal,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

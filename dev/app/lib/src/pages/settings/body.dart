import 'package:app/src/blocs/alert/index.dart';
import 'package:app/src/design_system/buttons/option.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AlertBloc alertBloc;

  @override
  void initState() {
    alertBloc = BlocProvider.of<AlertBloc>(context);
    super.initState();
  }

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
          Option(
            label: 'Change Email',
          ),
          Option(
            label: 'Change Password',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
          ),
          Option(
            label: 'Logout',
            color: Colors.red,
            onClick: () {
              alertBloc..add(Show());
            },
          ),
          Option(
            label: 'Delete Account',
            color: Colors.black54,
            withIcon: false,
          ),
        ],
      ),
    );
  }
}

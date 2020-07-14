import 'package:app/src/blocs/alert/index.dart';
import 'package:app/src/blocs/theme/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/option.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/settings/change.dart';
import 'package:app/src/pages/settings/change_accessibility/accessibility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import './change_email/email.dart';
import './change_password/password.dart';
import './change_language/language.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AlertBloc alertBloc;
  bool theme;

  @override
  void initState() {
    alertBloc = BlocProvider.of<AlertBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return Container(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: TopIconBack(
                  icon: FeatherIcons.arrowLeft,
                  color: (!theme)
                      ? LightPalette().colors["Palette.textPrimary"]
                      : DarkPalette().colors["Palette.textPrimary"],
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
            color: Palette.textPrimary,
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Change(
                    child: Email(),
                  ),
                ),
              );
            },
          ),
          Option(
            label: 'Change Password',
            color: Palette.textPrimary,
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Change(
                    child: Password(),
                  ),
                ),
              );
            },
          ),
          Option(
            label: 'Change Language',
            color: Palette.textPrimary,
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Change(
                    child: LanguageBody(),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Change(
                    child: Accessiblity(),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 32,
              ),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: (!theme)
                    ? LightPalette().colors["Palette.backgroundSecondary"]
                    : DarkPalette().colors["Palette.backgroundSecondary"],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  CText(
                    'Acessible Mode',
                    size: 24,
                    weight: FontWeight.bold,
                    hPadding: 0,
                    top: 8,
                    bottom: 0,
                  ),
                  CText(
                    'Big fonts, higher contrast.',
                    size: 16,
                    weight: FontWeight.w600,
                    hPadding: 0,
                    top: 8,
                    bottom: 24,
                  ),
                  /*Button(
                    type: ButtonType.primaryStroke,
                    dims: ButtonDims.medium,
                    label: 'Try it now',
                  )*/
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
          ),
          Option(
            label: 'Logout',
            color: Palette.textAccent,
            onClick: () {
              alertBloc..add(Show());
            },
          ),
          Option(
            label: 'Delete Account',
            color: Palette.textSecondary50,
            withIcon: false,
          ),
        ],
      ),
    );
  }
}

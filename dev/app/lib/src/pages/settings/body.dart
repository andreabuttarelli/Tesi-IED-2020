import 'package:app/src/blocs/alert/index.dart';
import 'package:app/src/blocs/language/index.dart';
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
    return BlocBuilder<LanguageBloc, Language>(
      builder: (context, lang) {
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
                '${lang.script["settings_title"]}',
                size: 32,
                weight: FontWeight.bold,
                hPadding: 24,
                top: 8,
                bottom: 24,
              ),
              Option(
                label: '${lang.script["settings_change_email"]}',
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
                label: '${lang.script["settings_change_password"]}',
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
                label: '${lang.script["settings_change_lang"]}',
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
                        '${lang.script["accessible_mode_title"]}',
                        size: 24,
                        weight: FontWeight.bold,
                        hPadding: 0,
                        top: 8,
                        bottom: 0,
                      ),
                      Container(
                        child: Wrap(
                          children: [
                            CText(
                              '${lang.script["accessible_mode_description"]}',
                              size: 16,
                              weight: FontWeight.w600,
                              hPadding: 0,
                              top: 8,
                              bottom: 24,
                            ),
                          ],
                        ),
                      ),
                      Button(
                        color: Palette.textPrimary,
                        type: ButtonType.primaryStroke,
                        dims: ButtonDims.medium,
                        label: 'Try it now',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
              ),
              Option(
                label: '${lang.script["settings_logout"]}',
                color: Palette.textAccent,
                onClick: () {
                  alertBloc..add(Show());
                },
              ),
              Option(
                label: '${lang.script["settings_delete_account"]}',
                color: Palette.textSecondary50,
                withIcon: false,
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:app/src/blocs/accessibility/index.dart';
import 'package:app/src/blocs/feed/index.dart';
import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/option.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/settings/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Accessiblity extends StatefulWidget {
  Accessiblity({Key key}) : super(key: key);

  @override
  _AccessiblityState createState() => _AccessiblityState();
}

class _AccessiblityState extends State<Accessiblity> {
  AccessibilityBloc accessibilityBloc;

  @override
  void initState() {
    accessibilityBloc = BlocProvider.of<AccessibilityBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessibilityBloc, bool>(
      builder: (context, isAccessible) {
        return SafeArea(
          child: ListView(
            children: [
              Row(
                children: [
                  TopIconBack(
                    icon: Icons.arrow_back,
                    color: Colors.black,
                  ),
                ],
              ),
              BlocBuilder<LanguageBloc, Language>(
                builder: (context, lang) {
                  return CText(
                    '${lang.script["change_language_title"]}',
                    size: 32,
                    weight: FontWeight.bold,
                    hPadding: 24,
                    top: 8,
                    bottom: 24,
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  accessibilityBloc..add(ChangeAccessibleMode(false));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 0,
                  ),
                  padding: const EdgeInsets.all(24),
                  width: double.maxFinite,
                  height: 180,
                  decoration: BoxDecoration(
                    color:
                        (!isAccessible) ? Color(0xFFe7e7e7) : Color(0xFFf1f1f1),
                    border: (!isAccessible)
                        ? Border.all(color: Colors.black45, width: 4)
                        : Border.all(
                            color: Colors.black.withOpacity(0.0), width: 0),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      CText(
                        'Default',
                        size: 24,
                        weight: FontWeight.bold,
                        hPadding: 0,
                        top: 8,
                        bottom: 0,
                      ),
                      CText(
                        '',
                        size: 16,
                        weight: FontWeight.w600,
                        hPadding: 0,
                        top: 8,
                        bottom: 24,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  accessibilityBloc..add(ChangeAccessibleMode(true));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  padding: const EdgeInsets.all(24),
                  width: double.maxFinite,
                  height: 180,
                  decoration: BoxDecoration(
                    color:
                        (isAccessible) ? Color(0xFFe7e7e7) : Color(0xFFf1f1f1),
                    border: (isAccessible)
                        ? Border.all(color: Colors.black45, width: 4)
                        : Border.all(
                            color: Colors.black.withOpacity(0.0), width: 0),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      CText(
                        'Accessible Mode 🏳️‍🌈',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

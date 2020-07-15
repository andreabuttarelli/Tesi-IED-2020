import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/details/norms/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import './text.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, Language>(
      builder: (context, lang) {
        return ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopIconBack(
                  icon: FeatherIcons.arrowLeft,
                ),
              ],
            ),
            CText(
              '${lang.script['banner_covid_title']}',
              size: 32,
              weight: FontWeight.w700,
              left: 24,
              right: 24,
            ),
            CText(
              (lang is Italian)
                  ? '${TextBody().italian}'
                  : (lang is English)
                      ? '${TextBody().english}'
                      : (lang is Spanish)
                          ? '${TextBody().spanish}'
                          : '${TextBody().chinese}',
              size: 16,
              weight: FontWeight.w200,
              top: 24,
              left: 24,
              right: 24,
            ),
          ],
        );
      },
    );
  }
}

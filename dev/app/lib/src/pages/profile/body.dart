import 'package:app/src/blocs/theme/index.dart';
import 'package:app/src/blocs/user/index.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/objects/local_article.dart';
import 'package:app/src/objects/user.dart';
import 'package:app/src/pages/settings/settings.dart';
import 'package:app/src/repositories/local_feed.dart';

/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 04/07/2020

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import './article.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool theme;

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });

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
                  color: (!theme)
                      ? LightPalette().colors["Palette.textPrimary"]
                      : DarkPalette().colors["Palette.textPrimary"],
                ),
                TopIcon(
                  icon: FeatherIcons.settings,
                  color: (!theme)
                      ? LightPalette().colors["Palette.textPrimary"]
                      : DarkPalette().colors["Palette.textPrimary"],
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
          FutureBuilder(
            future: LocalFeedRepository().getArticles(),
            builder: (BuildContext context,
                AsyncSnapshot<List<LocalArticle>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CText(
                      'Here you can find all your pinned articles',
                      size: 16,
                      color: Palette.textPrimary,
                      weight: FontWeight.normal,
                    ),
                  );
                }
                return Column(
                  children: snapshot.data
                      .map((article) => ArticleWidget(
                            post: article,
                          ))
                      .toList(),
                );
              } else {
                return Center(
                  child: CText(
                    'Sorry, something went wrong',
                    size: 16,
                    color: Palette.textPrimary,
                    weight: FontWeight.normal,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

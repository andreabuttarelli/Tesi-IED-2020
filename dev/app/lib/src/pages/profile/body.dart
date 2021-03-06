import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/objects/local_article.dart';
import 'package:app/src/pages/profile/pittograms.dart';
import 'package:app/src/pages/settings/settings.dart';
import 'package:app/src/repositories/local_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import './article.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool theme;
  bool isPulled = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });

    return BlocBuilder<LanguageBloc, Language>(
      builder: (context, lang) {
        return Container(
          child: LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            showChildOpacityTransition: false,
            animSpeedFactor: 4,
            color: Color(0xFFA92217),
            height: 100,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
              },
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  SafeArea(
                    bottom: false,
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
                              MaterialPageRoute(
                                  builder: (context) => Settings()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  CText(
                    '${lang.script["profile_title"]}',
                    size: 32,
                    weight: FontWeight.bold,
                    hPadding: 24,
                    top: 8,
                    bottom: 0,
                  ),
                  Pittograms(),
                  FutureBuilder(
                    future: LocalFeedRepository().getArticles(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<LocalArticle>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  '${lang.script["profile_favorites_title"]}',
                                  size: 24,
                                  weight: FontWeight.bold,
                                  color: Palette.textPrimary,
                                  top: 16,
                                ),
                                CText(
                                  '${lang.script["profile_favorites_subtitle"]}',
                                  size: 16,
                                  color: Palette.textPrimary,
                                  weight: FontWeight.normal,
                                ),
                              ],
                            ),
                          );
                        }
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CText(
                                '${lang.script["profile_favorites_title"]}',
                                size: 24,
                                weight: FontWeight.bold,
                                color: Palette.textPrimary,
                                top: 16,
                                hPadding: 24,
                                bottom: 8,
                              ),
                              Column(
                                children: snapshot.data
                                    .map((article) => ArticleWidget(
                                          post: article,
                                          callBack: () {
                                            print('callBack');
                                            setState(() {
                                              isPulled = false;
                                            });
                                          },
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
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
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isPulled = true;
    });
  }
}

import 'package:app/src/blocs/feed/index.dart';
import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/buttons/option.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/settings/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class LanguageBody extends StatefulWidget {
  LanguageBody({Key key}) : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<LanguageBody> {
  bool isValid = false;
  int lenght = 0;
  String email = '';
  LanguageBloc languageBloc;
  FeedBloc feedBloc;

  @override
  void initState() {
    languageBloc = BlocProvider.of<LanguageBloc>(context);
    feedBloc = BlocProvider.of<FeedBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, Language>(
      builder: (context, lang) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopIconBack(
                icon: Icons.arrow_back,
                color: Colors.black,
              ),
              CText(
                '${lang.script["change_language_title"]}',
                size: 32,
                weight: FontWeight.bold,
                hPadding: 24,
                top: 8,
                bottom: 24,
              ),
              Option(
                color: (lang == Italian())
                    ? Colors.black
                    : Colors.black.withOpacity(0.7),
                label: '🇮🇹 Italiano',
                withIcon: (lang == Italian()),
                icon: FeatherIcons.check,
                onClick: () {
                  languageBloc..add(ChangeLanguage(lang: Italian()));
                  feedBloc..add(Restart());
                },
              ),
              Option(
                color: (lang == English())
                    ? Colors.black
                    : Colors.black.withOpacity(0.7),
                label: '🇬🇧 English',
                withIcon: (lang == English()),
                icon: FeatherIcons.check,
                onClick: () {
                  languageBloc..add(ChangeLanguage(lang: English()));
                  feedBloc..add(Restart());
                },
              ),
              Option(
                color: (lang == Spanish())
                    ? Colors.black
                    : Colors.black.withOpacity(0.7),
                label: '🇪🇸 Español',
                withIcon: (lang == Spanish()),
                icon: FeatherIcons.check,
                onClick: () {
                  languageBloc..add(ChangeLanguage(lang: Spanish()));
                  feedBloc..add(Restart());
                },
              ),
              Option(
                color: (lang == Chinese())
                    ? Colors.black
                    : Colors.black.withOpacity(0.7),
                label: '🇨🇳 中文',
                withIcon: (lang == Chinese()),
                icon: FeatherIcons.check,
                onClick: () {
                  languageBloc..add(ChangeLanguage(lang: Chinese()));
                  feedBloc..add(Restart());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

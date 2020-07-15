import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/auth/pre_login.dart';
import 'package:app/src/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class UserProfileButton extends StatefulWidget {
  UserProfileButton({Key key}) : super(key: key);

  @override
  _UserProfileButtonState createState() => _UserProfileButtonState();
}

class _UserProfileButtonState extends State<UserProfileButton> {
  double opacity = 1;
  bool theme;

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    });
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Unauthenticated) {
          return AnimatedOpacity(
            opacity: opacity,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PreLogin()),
                    );
                  },
                  onTapDown: (detail) => tapped(),
                  onTapUp: (detail) => notTapped(),
                  onTapCancel: () => notTapped(),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 12),
                    decoration: BoxDecoration(
                      color: (!theme)
                          ? LightPalette().colors["Palette.backgroundSecondary"]
                          : DarkPalette()
                              .colors["Palette.backgroundSecondary"], //A92217
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      FeatherIcons.user,
                      size: 24,
                      color: (!theme)
                          ? LightPalette().colors["Palette.textPrimary"]
                          : DarkPalette().colors["Palette.textPrimary"],
                    ),
                    /*BlocBuilder<LanguageBloc, Language>(
                      builder: (context, lang) {
                        return CText(
                          '${lang.script["feed_profile_notlogged"]}',
                          size: 16,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        );
                      },
                    ),*/
                  ),
                ),
              ],
            ),
          );
        }

        if (state is Authenticated) {
          return AnimatedOpacity(
            opacity: opacity,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  onTapDown: (detail) => tapped(),
                  onTapUp: (detail) => notTapped(),
                  onTapCancel: () => notTapped(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFFe7e7e7),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  tapped() {
    setState(() {
      opacity = 0.5;
    });
  }

  notTapped() {
    setState(() {
      opacity = 1;
    });
  }
}

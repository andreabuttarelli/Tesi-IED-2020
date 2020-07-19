import 'dart:ui';
import 'package:app/src/blocs/accessibility/index.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/objects/local_article.dart';
import 'package:app/src/objects/place.dart';
import 'package:app/src/pages/notes/editor/action_bar/action_bar.dart';
import 'package:app/src/repositories/local_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:share/share.dart';
import 'package:webfeed/domain/atom_item.dart';
import './content.dart';

class Body extends StatefulWidget {
  Place place;
  Body({Key key, @required this.place}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var top = 0.0;
  var topBody = 0.0;
  var topPadding = 330;
  bool theme;
  bool isLiked = false;
  bool isFirstTime = true;
  AccessibilityBloc accessibilityBloc;

  @override
  void initState() {
    accessibilityBloc = BlocProvider.of<AccessibilityBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: NotificationListener(
        onNotification: (v) {
          if (v is ScrollUpdateNotification) {
            setState(() => top -= v.scrollDelta / 2);
            setState(() => topBody -= v.scrollDelta);
          }
        },
        child: Stack(
          children: [
            Positioned(
              top: top + 120,
              child: Hero(
                tag: widget.place.name,
                child: Container(
                  width: width,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${widget.place.image}'),
                        fit: BoxFit.cover,
                      ),
                      color: (!theme)
                          ? LightPalette().colors["${Palette.textSecondary70}"]
                          : DarkPalette().colors["${Palette.textSecondary70}"]),
                ),
              ),
            ),
            Content(
              place: widget.place,
              top: (110 + 190.0),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  padding: const EdgeInsets.only(top: 16),
                  width: double.maxFinite,
                  color: (!theme)
                      ? LightPalette().colors["${Palette.backgroundPrimary}"]
                      : DarkPalette()
                          .colors["${Palette.backgroundPrimary}"]
                          .withOpacity(0.4),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: TopIconBack(
                            icon: FeatherIcons.arrowLeft,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              TopIcon(
                                icon: FeatherIcons.share,
                                onClick: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //ActionBar(),
          ],
        ),
      ),
    );
  }
}

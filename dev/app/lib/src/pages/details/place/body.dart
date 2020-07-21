import 'dart:ui';
import 'package:app/src/blocs/accessibility/index.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/objects/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import './content.dart';

class Body extends StatefulWidget {
  Place place;
  Body({
    Key key,
    @required this.place,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var top = 0.0;
  var topBody = 0.0;
  var topPadding = 330;
  bool theme;
  double height;
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
      height = MediaQuery.of(context).size.height * 0.7;
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
              top: top,
              child: Hero(
                tag: widget.place.id,
                child: Container(
                  width: width * 2,
                  height: height + 48,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${widget.place.image}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Content(
              place: widget.place,
              top: height,
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Container(
                  padding: const EdgeInsets.only(top: 16),
                  width: double.maxFinite,
                  color: (!theme)
                      ? LightPalette()
                          .colors["${Palette.backgroundPrimary}"]
                          .withOpacity(0.4)
                      : DarkPalette()
                          .colors["${Palette.backgroundPrimary}"]
                          .withOpacity(0.4),
                  child: SafeArea(
                    bottom: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                          },
                          child: TopIconBack(
                            icon: FeatherIcons.arrowLeft,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              BlocBuilder<AccessibilityBloc, bool>(
                                builder: (context, isAccessible) {
                                  return TopIcon(
                                      icon: FeatherIcons.shield,
                                      color:
                                          (isAccessible) ? Colors.blue : null,
                                      onClick: (isAccessible)
                                          ? () {
                                              accessibilityBloc
                                                ..add(ChangeAccessibleMode(
                                                    false));
                                            }
                                          : () {
                                              accessibilityBloc
                                                ..add(
                                                    ChangeAccessibleMode(true));
                                            });
                                },
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

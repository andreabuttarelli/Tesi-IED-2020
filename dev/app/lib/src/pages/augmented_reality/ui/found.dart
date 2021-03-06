import 'dart:ui';
import 'dart:async';
import 'package:app/src/blocs/augmented_reality/index.dart';
import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/blocs/token/bloc.dart';
import 'package:app/src/blocs/token/state.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Found extends StatefulWidget {
  Found({Key key}) : super(key: key);

  @override
  _FoundState createState() => _FoundState();
}

class _FoundState extends State<Found> {
  ARBloc arBloc;
  bool theme;
  bool flagAction = false;

  @override
  void initState() {
    arBloc = BlocProvider.of<ARBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopIconBack(
                    icon: FeatherIcons.x,
                    color: Colors.white,
                  ),
                  TopIcon(
                    icon: FeatherIcons.helpCircle,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CText(
                    'Detected!',
                    size: 32,
                    weight: FontWeight.bold,
                    color: Palette.white,
                    hPadding: 24,
                    top: 24,
                    bottom: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<TokenBloc, TokenState>(
          builder: (context, state) {
            if (state is Null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PlaceFound) {
              showPosts();

              return BlocBuilder<LanguageBloc, Language>(
                builder: (context, lang) {
                  showPosts();
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 32,
                            ),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: (!theme)
                                  ? LightPalette()
                                      .colors["Palette.backgroundSecondary"]
                                  : DarkPalette()
                                      .colors["Palette.backgroundSecondary"],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 64,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          color: (!theme)
                                              ? LightPalette()
                                                  .colors["Palette.textPrimary"]
                                                  .withOpacity(0.3)
                                              : DarkPalette()
                                                  .colors["Palette.textPrimary"]
                                                  .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(60),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            FeatherIcons.camera,
                                            size: 24,
                                            color: (!theme)
                                                ? LightPalette().colors[
                                                    "Palette.textPrimary"]
                                                : DarkPalette().colors[
                                                    "Palette.textPrimary"],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CText(
                                        'Lascia il segno',
                                        size: 16,
                                        weight: FontWeight.w300,
                                        hPadding: 0,
                                        top: 0,
                                        bottom: 0,
                                        left: 16,
                                      ),
                                      Container(
                                        child: Wrap(
                                          children: [
                                            CText(
                                              '${state.place.name}',
                                              size: 20,
                                              weight: FontWeight.bold,
                                              hPadding: 0,
                                              top: 4,
                                              bottom: 0,
                                              left: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
            return Container();
          },
        ),
      ],
    );
  }

  showPosts() async {
    const oneSec = const Duration(milliseconds: 300);
    new Timer.periodic(oneSec, (Timer t) => arBloc..add(ShowPosts()));
  }
}

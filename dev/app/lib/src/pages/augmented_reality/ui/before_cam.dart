import 'package:app/src/blocs/augmented_reality/index.dart';
import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/blocs/token/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/camera/camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class BeforeCamera extends StatefulWidget {
  BeforeCamera({Key key}) : super(key: key);

  @override
  _BeforeCameraState createState() => _BeforeCameraState();
}

class _BeforeCameraState extends State<BeforeCamera> {
  bool flagAction = false;
  bool theme;
  ARBloc arBloc;
  TokenBloc tokenBloc;

  @override
  void initState() {
    arBloc = BlocProvider.of<ARBloc>(context);
    tokenBloc = BlocProvider.of<TokenBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return BlocBuilder<LanguageBloc, Language>(
      builder: (context, lang) {
        return BlocBuilder<TokenBloc, TokenState>(
          builder: (context, state) {
            if (state is Null || flagAction) {
              return Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is PlaceFound) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          flagAction = true;
                        });
                        arBloc..add(OpenCamera());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Camera(),
                              fullscreenDialog: true),
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
                              decoration: BoxDecoration(
                                color: (!theme)
                                    ? LightPalette()
                                        .colors["Palette.textPrimary"]
                                        .withOpacity(0.3)
                                    : DarkPalette()
                                        .colors["Palette.textPrimary"]
                                        .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: Center(
                                child: Icon(
                                  FeatherIcons.camera,
                                  size: 24,
                                  color: (!theme)
                                      ? LightPalette()
                                          .colors["Palette.textPrimary"]
                                      : DarkPalette()
                                          .colors["Palette.textPrimary"],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
            }
            return Container();
          },
        );
      },
    );
  }
}

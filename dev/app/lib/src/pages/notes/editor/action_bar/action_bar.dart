import 'dart:ui';
import 'package:app/src/blocs/editor/bloc.dart';
import 'package:app/src/blocs/editor/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/notes/editor/action_bar/action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ActionBar extends StatefulWidget {
  ActionBar({Key key}) : super(key: key);

  @override
  _ActionBarState createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  bool theme;
  EditorBloc editorBloc;

  @override
  void initState() {
    editorBloc = BlocProvider.of<EditorBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return SafeArea(
      top: false,
      bottom: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(
                padding: const EdgeInsets.only(bottom: 16, top: 8),
                width: double.maxFinite,
                color: (!theme)
                    ? LightPalette().colors["${Palette.backgroundSecondary}"]
                    : DarkPalette()
                        .colors["${Palette.backgroundSecondary}"]
                        .withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    ActionIcon(
                      icon: FeatherIcons.type,
                      onClick: () {},
                    ),
                    ActionIcon(
                      icon: FeatherIcons.image,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

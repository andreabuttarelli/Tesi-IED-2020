import 'package:app/src/blocs/new_note/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/notes/new/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import './body.dart';

class NewNote extends StatefulWidget {
  NewNote({Key key}) : super(key: key);

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  NewNoteBloc newNoteBloc;

  @override
  void initState() {
    newNoteBloc = BlocProvider.of<NewNoteBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          (MediaQuery.of(context).platformBrightness == Brightness.dark)
              ? DarkPalette().colors['${Palette.backgroundPrimary}']
              : LightPalette().colors['${Palette.backgroundPrimary}'],
      body: LiquidPullToRefresh(
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
            children: [
              Header(),
              CText(
                'Vicini a te',
                size: 16,
                weight: FontWeight.normal,
                color: Palette.textPrimary,
                hPadding: 24,
                top: 40,
              ),
              Body(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    newNoteBloc..add(Restart());
    await Future.delayed(Duration(milliseconds: 500));
    return;
  }
}

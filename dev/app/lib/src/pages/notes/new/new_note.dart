import 'package:app/src/blocs/new_note/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './body.dart';

class NewNote extends StatelessWidget {
  const NewNote({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewNoteBloc()..add(Fetch()),
      child: Scaffold(
        backgroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.dark)
                ? DarkPalette().colors['${Palette.backgroundPrimary}']
                : LightPalette().colors['${Palette.backgroundPrimary}'],
        body: Body(),
      ),
    );
  }
}

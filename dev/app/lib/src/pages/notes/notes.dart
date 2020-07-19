import 'package:app/src/blocs/notes/index.dart';

/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './body.dart';

class Notes extends StatelessWidget {
  const Notes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc()..add(Fetch()),
      child: Container(
        child: Body(),
      ),
    );
  }
}

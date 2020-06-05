/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020
///
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/src/blocs/navigation/bloc.dart';
import 'package:app/src/pages/feed/feed.dart';
import 'package:app/src/pages/notes/notes.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  NavigationBloc navigationBloc;

  @override
  void initState() {
    navigationBloc = BlocProvider.of<NavigationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, int>(
      bloc: navigationBloc,
      builder: (context, i) {
        print(i);
        return Stack(
          children: [
            Visibility(
              visible: (i == 0),
              child: Feed(),
            ),
            Visibility(
              visible: (i == 1),
              child: Notes(),
            ),
          ],
        );
      },
    );
  }
}

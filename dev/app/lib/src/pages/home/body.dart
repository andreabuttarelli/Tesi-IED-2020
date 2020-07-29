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
  int index = 0;
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
        FocusScope.of(context).unfocus();
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

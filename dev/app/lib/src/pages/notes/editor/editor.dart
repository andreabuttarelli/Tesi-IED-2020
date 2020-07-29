import 'package:app/src/blocs/editor/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/objects/local_note.dart';
import 'package:app/src/objects/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'body.dart';

class Editor extends StatefulWidget {
  Place place;
  LocalNote note;
  Editor({
    Key key,
    this.place,
    this.note,
  }) : super(key: key);

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  bool theme;
  Place place;

  @override
  void initState() {
    if (widget.note != null)
      place = Place(
          id: widget.note.id,
          name: widget.note.title,
          image: widget.note.image);
    else
      place = widget.place;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return BlocProvider(
      create: (context) => EditorBloc()..add(Update(place)),
      child: Scaffold(
        backgroundColor: (!theme)
            ? LightPalette().colors["${Palette.backgroundPrimary}"]
            : DarkPalette().colors["${Palette.backgroundPrimary}"],
        body: Stack(
          children: [
            Body(
              note: widget.note,
              place: widget.place,
            ),
          ],
        ),
      ),
    );
  }
}

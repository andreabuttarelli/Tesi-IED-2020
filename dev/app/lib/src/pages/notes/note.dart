import 'package:app/src/objects/local_note.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatefulWidget {
  LocalNote note;
  NoteWidget({Key key, this.note}) : super(key: key);

  @override
  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(),
    );
  }
}

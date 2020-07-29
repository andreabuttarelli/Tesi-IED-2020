import 'dart:ui';
import 'package:app/src/blocs/accessibility/index.dart';
import 'package:app/src/components/zefyr/zefyr.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/objects/local_note.dart';
import 'package:app/src/objects/place.dart';
import 'package:app/src/repositories/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:quill_delta/quill_delta.dart';
import 'dart:convert';

class Body extends StatefulWidget {
  Place place;
  LocalNote note;
  Body({Key key, this.place, this.note}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var top = 0.0;
  var topBody = 0.0;
  var topPadding = 330;
  bool theme;
  bool isLiked = false;
  bool isFirstTime = true;
  AccessibilityBloc accessibilityBloc;
  ZefyrController _controller;
  FocusNode _focusNode;
  Place place;

  @override
  void initState() {
    accessibilityBloc = BlocProvider.of<AccessibilityBloc>(context);
    _focusNode = FocusNode();
    if (widget.note != null)
      place = Place(
          id: widget.note.id,
          name: widget.note.title,
          image: widget.note.image);
    else
      place = widget.place;
    super.initState();
  }

  Future<NotusDocument> loadDocument() async {
    if (widget.note != null) {
      return NotusDocument.fromJson(jsonDecode(widget.note.content));
    }
    final Delta delta = Delta()..insert("Write here\n");
    return NotusDocument.fromDelta(delta);
  }

  void _saveDocument(BuildContext context) async {
    final contents = jsonEncode(_controller.document);
    final note = LocalNote(
        id: place.id,
        title: place.name,
        image: place.image,
        content: contents,
        date: DateTime.now().toString());
    final id = (widget.note == null)
        ? await LocalNotesRepository().insert(note)
        : await LocalNotesRepository().update(note);
    widget.note.content = note.content;
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: FutureBuilder<NotusDocument>(
        //initialData: initDoc,
        future: loadDocument(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return Center(
              child: Text(
                'Loading',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            );
          }
          _controller = ZefyrController(snapshot.data);
          return Stack(
            children: [
              ZefyrScaffold(
                child: ZefyrEditor(
                  controller: _controller,
                  focusNode: _focusNode,
                  mode: ZefyrMode.edit,
                ),
              ),
              ClipRect(
                child: Container(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      padding: const EdgeInsets.only(top: 0),
                      width: double.maxFinite,
                      color: (!theme)
                          ? LightPalette()
                              .colors["${Palette.backgroundSecondary}"]
                              .withOpacity(0.8)
                          : DarkPalette()
                              .colors["${Palette.backgroundSecondary}"]
                              .withOpacity(0.8),
                      child: SafeArea(
                        bottom: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: TopIconBack(
                                icon: FeatherIcons.arrowLeft,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                children: [
                                  TopIcon(
                                    icon: FeatherIcons.save,
                                    onClick: () {
                                      _saveDocument(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

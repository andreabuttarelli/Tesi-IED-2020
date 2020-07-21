import 'package:app/src/blocs/theme/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/objects/article.dart';
import 'package:app/src/objects/local_note.dart';
import 'package:app/src/pages/details/article/article.dart';
import 'package:app/src/pages/notes/editor/editor.dart';
import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:timeago/timeago.dart' as timeago;
import 'package:webfeed/domain/media/thumbnail.dart';

class NoteWidget extends StatefulWidget {
  final LocalNote note;
  NoteWidget({Key key, @required this.note}) : super(key: key);

  @override
  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  GlobalKey key =
      GlobalKey(); //add key to your widget, which position you need to find
  List<String> list = List();
  String thumbnail = '';
  double opacity = 1;
  bool theme;
  bool flagSecureFrame = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    });

    findPosition();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Editor(
              note: widget.note,
            ),
          ),
        );
      },
      onTapDown: (details) => toogleOpacity(),
      onTapCancel: () => toogleOpacity(),
      onTapUp: (details) => toogleOpacity(),
      child: AnimatedOpacity(
        opacity: opacity,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          decoration: BoxDecoration(
            color: (!theme)
                ? LightPalette().colors["Palette.backgroundSecondary"]
                : DarkPalette().colors["Palette.backgroundSecondary"],
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ContentPlaceholder(
                      height: 240,
                      bgColor: (!theme)
                          ? LightPalette()
                              .colors["${Palette.backgroundSecondary}"]
                          : DarkPalette()
                              .colors["${Palette.backgroundSecondary}"],
                      highlightColor: Colors.white,
                      spacing: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      child: Container(
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Hero(
                      tag: widget.note.id,
                      child: Container(
                        key: key,
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          image: DecorationImage(
                            image: NetworkImage('${widget.note.image}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24, bottom: 8, left: 16, right: 16),
                  child: CText(
                    '${widget.note.title}',
                    size: 20,
                    weight: FontWeight.w900,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 44, left: 16, right: 16),
                      child: CText(
                        '${timeago.format(DateTime.parse(widget.note.date))}',
                        size: 14,
                        weight: FontWeight.w500,
                        color: Palette.textSecondary50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  toogleOpacity() {
    if (opacity == 1) {
      setState(() {
        opacity = 0.6;
      });
    } else {
      setState(() {
        opacity = 1;
      });
    }
  }

  void _afterLayout(Duration duration) {
    setState(() {
      flagSecureFrame = true;
    });
  }

  findPosition() {
    if (flagSecureFrame) {
      RenderBox box = key.currentContext.findRenderObject();
      Offset position = box.localToGlobal(Offset.zero);
      double y = position.dy;
      print(y);
    }
  }
}

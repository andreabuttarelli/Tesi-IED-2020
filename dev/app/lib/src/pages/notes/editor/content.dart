import 'package:app/src/blocs/accessibility/bloc.dart';
import 'package:app/src/blocs/editor/bloc.dart';
import 'package:app/src/blocs/theme/bloc.dart';
import 'package:app/src/blocs/theme/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/objects/local_article.dart';
import 'package:app/src/objects/local_note.dart';
import 'package:app/src/objects/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:share/share.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

class Content extends StatefulWidget {
  Place place;
  LocalNote note;
  double top;
  Content({
    Key key,
    this.note,
    this.place,
    this.top,
  }) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  ZefyrController controller;
  FocusNode focusNode;
  bool theme;

  @override
  void initState() {
    final document = loadDocument();
    controller = ZefyrController(document);
    focusNode = FocusNode();
    super.initState();
  }

  NotusDocument loadDocument() {
    final Delta delta = Delta()..insert('Ciao\n');
    return NotusDocument.fromDelta(delta);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return ZefyrScaffold(
      child: ZefyrEditor(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        controller: controller,
        focusNode: focusNode,
      ),
    );
    /*BlocBuilder<EditorBloc, List<Widget>>(
      builder: (context, list) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
            },
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: widget.top),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: (!theme)
                        ? LightPalette().colors["${Palette.backgroundPrimary}"]
                        : DarkPalette().colors["${Palette.backgroundPrimary}"],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CText(
                          '${widget.place.name}',
                          size: 24,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Column(
                        children: list ?? [],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );*/
  }

  onUrlTap(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

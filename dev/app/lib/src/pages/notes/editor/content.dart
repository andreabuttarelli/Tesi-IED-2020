import 'package:app/src/components/zefyr/zefyr.dart';
import 'package:app/src/objects/place.dart';
import 'package:app/src/pages/notes/editor/delegates/mtoolbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Content extends StatefulWidget {
  Place place;
  NotusDocument document;
  double top;
  Content({
    Key key,
    this.document,
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return MzefyrEditor(doc: widget.document);
  }

  onUrlTap(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class MzefyrEditor extends StatefulWidget {
  MzefyrEditor({Key key, this.doc}) : super(key: key);
  final NotusDocument doc;
  @override
  _MzefyrEditorState createState() => _MzefyrEditorState();
}

class _MzefyrEditorState extends State<MzefyrEditor> {
  /// Allows to control the editor and the document.
  ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _controller = ZefyrController(widget.doc);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return ZefyrScaffold(
      child: ZefyrEditor(
        controller: _controller,
        focusNode: _focusNode,
        mode: ZefyrMode.edit,
      ),
    );
  }
}

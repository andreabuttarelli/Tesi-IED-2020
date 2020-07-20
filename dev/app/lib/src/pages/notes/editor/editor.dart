import 'package:app/src/blocs/editor/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/objects/local_article.dart';
import 'package:app/src/objects/local_note.dart';
import 'package:app/src/objects/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'body.dart';
import 'package:timeago/timeago.dart' as timeago;

class Editor extends StatefulWidget {
  Place place;
  Editor({
    Key key,
    this.place,
  }) : super(key: key);

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  bool theme;

  @override
  void initState() {
    /*if (widget.localNote != null) {
      local+ = LocalArticle(
        id: widget.post.id,
        title: widget.post.title,
        image: widget.thumbnail,
        category: '${widget.post.categories[0].term}',
        date: widget.post.published,
        content: widget.post.content,
        link: widget.post.id,
      );
    }
    if (widget.localArticle != null) {
      post = widget.localArticle;
    }*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return BlocProvider(
      create: (context) => EditorBloc()..add(Update(widget.place)),
      child: Scaffold(
        backgroundColor: (!theme)
            ? LightPalette().colors["${Palette.backgroundSecondary}"]
            : Color(0xFF333333).withOpacity(0.6),
        body: Stack(
          children: [
            Body(
              place: widget.place,
            ),
          ],
        ),
      ),
    );
  }
}

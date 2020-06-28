import 'package:flutter/material.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'body.dart';

class Article extends StatefulWidget {
  AtomItem post;
  String thumbnail;
  Article({Key key, @required this.post, this.thumbnail}) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Body(
          post: widget.post,
          thumbnail: widget.thumbnail,
        ),
      ],
    );
  }
}

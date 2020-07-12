import 'package:app/src/objects/local_article.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'body.dart';
import 'package:timeago/timeago.dart' as timeago;

class Article extends StatefulWidget {
  AtomItem post;
  LocalArticle localArticle;
  String thumbnail;
  Article({
    Key key,
    this.post,
    this.thumbnail,
    this.localArticle,
  }) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  LocalArticle post = LocalArticle();

  @override
  void initState() {
    if (widget.post != null) {
      post = LocalArticle(
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
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      body: Stack(
        children: [
          Body(
            post: post,
            thumbnail: widget.thumbnail,
          ),
        ],
      ),
    );
  }
}

import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/objects/local_article.dart';
import 'package:app/src/repositories/local_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:share/share.dart';
import 'package:webfeed/domain/atom_item.dart';
import './content.dart';

class Body extends StatefulWidget {
  LocalArticle post;
  String thumbnail;
  Body({Key key, @required this.post, this.thumbnail}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var top = 0.0;
  var topBody = 0.0;
  var topPadding = 330;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      body: new NotificationListener(
        onNotification: (v) {
          if (v is ScrollUpdateNotification) {
            setState(() => top -= v.scrollDelta / 2);
            setState(() => topBody -= v.scrollDelta);
          }
        },
        child: Stack(
          children: [
            Positioned(
              top: top + 84,
              child: Hero(
                tag: widget.post.id,
                child: Container(
                  width: width,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${widget.thumbnail}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Content(
              post: widget.post,
              top: topBody + 84 + 290,
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              width: double.maxFinite,
              color: Colors.white,
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
                          icon: FeatherIcons.share,
                          onClick: () => Share.share('${widget.post.id}',
                              subject: '${widget.post.title}'),
                        ),
                        TopIcon(
                          icon: FeatherIcons.shield,
                          onClick: () => Share.share('${widget.post.id}',
                              subject: '${widget.post.title}'),
                        ),
                        TopIcon(
                          icon: FeatherIcons.heart,
                          onClick: () async {
                            var result = await LocalFeedRepository()
                                .getArticle(widget.post.id);
                            print(result);
                            if (result == null)
                              insertLike();
                            else
                              removeLike();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> insertLike() async {
    final article = LocalArticle(
      id: widget.post.id,
      title: widget.post.title,
      image: widget.thumbnail,
      category: '${widget.post.category}',
      date: widget.post.date,
      content: widget.post.content,
      link: widget.post.id,
    );
    var result = await LocalFeedRepository().insert(article);
    if (result == null)
      return false;
    else {
      print('New Article inserted: $result');
      return true;
    }
  }

  Future<bool> removeLike() async {
    var result = await LocalFeedRepository().delete(widget.post.id);
    if (result == null) {
    } else {
      print('Pinned Article removed: $result');
      return true;
    }
  }
}

import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/atom_item.dart';
import './body.dart';

class Article extends StatefulWidget {
  AtomItem post;
  String thumbnail;
  Article({Key key, @required this.post, this.thumbnail}) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  var top = 0.0;
  var topBody = 0.0;
  var topPadding = 330;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
            Body(
              post: widget.post,
              top: topBody + 84 + 290,
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              width: double.maxFinite,
              color: Colors.white,
              child: Row(
                children: [
                  TopIcon(
                    icon: Icons.arrow_back,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

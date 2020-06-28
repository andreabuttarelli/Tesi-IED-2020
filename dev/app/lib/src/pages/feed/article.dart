import 'package:app/src/design_system/text.dart';

/// MIT License
/// by Andrea Buttarelli
/// creato il 05/06/2020
/// modificato il 05/06/2020

import 'package:app/src/objects/article.dart';
import 'package:app/src/pages/details/article/article.dart';
import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:timeago/timeago.dart' as timeago;
import 'package:webfeed/domain/media/thumbnail.dart';

class ArticleWidget extends StatefulWidget {
  final AtomItem post;
  ArticleWidget({Key key, @required this.post}) : super(key: key);

  @override
  _ArticleWidgetState createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  List<String> list = List();
  String thumbnail = '';
  double opacity = 1;

  void _getData() async {
    final response = await http.get('${widget.post.id}');
    dom.Document document = parser.parse(response.body);
    final elements = document.getElementsByClassName('wp-post-image');

    print(elements.length);

    var image = elements.map((element) => element.attributes["src"]).toList();
    setState(() {
      thumbnail = image[0];
      widget.post.media.thumbnails.add(Thumbnail(url: thumbnail));
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Article(
              post: widget.post,
              thumbnail: thumbnail,
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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          color: (opacity == 1) ? Colors.transparent : Color(0xFFe7e7e7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (thumbnail != '')
                  ? Hero(
                      tag: widget.post.id,
                      child: Container(
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          image: DecorationImage(
                            image: (widget.post.media.thumbnails.isNotEmpty)
                                ? NetworkImage(
                                    '${widget.post.media.thumbnails[0].url}')
                                : NetworkImage('$thumbnail'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    )
                  : ContentPlaceholder(
                      height: 240,
                      bgColor: Colors.black45,
                      highlightColor: Colors.white,
                      spacing: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 0),
                      child: Container(
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 4),
                child: CText(
                  '${widget.post.title}',
                  size: 20,
                  weight: FontWeight.w800,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: CText(
                      '${widget.post.categories[0].term}',
                      size: 14,
                      weight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: CText(
                      '${timeago.format(DateTime.parse(widget.post.published))}',
                      size: 14,
                      weight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  toogleOpacity() {
    if (opacity == 1) {
      setState(() {
        opacity = 0.8;
      });
    } else {
      setState(() {
        opacity = 1;
      });
    }
  }
}

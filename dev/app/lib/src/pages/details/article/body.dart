import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:timeago/timeago.dart' as timeago;

class Body extends StatefulWidget {
  AtomItem post;
  double top;
  Body({
    Key key,
    @required this.post,
    this.top,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    print(widget.post.content);
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
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CText(
                      '${widget.post.title}',
                      size: 32,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
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
                  ),
                  Html(
                    data: widget.post.content,
                    style: {
                      "div": Style(
                        fontSize: FontSize.large,
                        fontWeight: FontWeight.bold,
                      ),
                    },
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

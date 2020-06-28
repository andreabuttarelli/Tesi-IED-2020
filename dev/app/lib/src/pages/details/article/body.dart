import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:share/share.dart';
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CText(
                      '${widget.post.title}',
                      size: 32,
                      weight: FontWeight.w700,
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
                        fontSize: FontSize(18),
                        fontWeight: FontWeight.bold,
                      ),
                      "p": Style(
                        fontSize: FontSize(18),
                        fontWeight: FontWeight.bold,
                      ),
                      "blockquote p": Style(
                        fontSize: FontSize(22),
                        fontWeight: FontWeight.w700,
                        fontFamily: "GilroyMedium",
                        color: Colors.black.withOpacity(0.8),
                      ),
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 24),
                    child: Button(
                      label: 'Share',
                      type: ButtonType.secondarySolid,
                      dims: ButtonDims.medium,
                      onClick: () {
                        Share.share('${widget.post.id}',
                            subject: '${widget.post.title}');
                      },
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
}

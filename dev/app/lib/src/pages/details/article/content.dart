import 'package:app/src/blocs/accessibility/bloc.dart';
import 'package:app/src/blocs/theme/bloc.dart';
import 'package:app/src/blocs/theme/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/objects/local_article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:share/share.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class Content extends StatefulWidget {
  LocalArticle post;
  double top;
  Content({
    Key key,
    @required this.post,
    this.top,
  }) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessibilityBloc, bool>(
      builder: (context, isAccessible) {
        return BlocBuilder<ThemeBloc, ThemeEnum>(
          builder: (context, theme) => Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CText(
                            '${widget.post.title}',
                            size: 24,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 16),
                                child: CText(
                                  '${widget.post.category}',
                                  size: 14,
                                  weight: FontWeight.bold,
                                  color: Palette.textSecondary80,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 16),
                                child: CText(
                                  '${timeago.format(DateTime.parse(widget.post.date))}',
                                  size: 14,
                                  weight: FontWeight.w600,
                                  color: Palette.textSecondary50,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Html(
                          data: widget.post.content,
                          style: {
                            "div": Style(
                              fontSize:
                                  FontSize((isAccessible) ? 18 * 1.2 : 18),
                              fontWeight: FontWeight.bold,
                            ),
                            "p": Style(
                              fontSize:
                                  FontSize((isAccessible) ? 18 * 1.2 : 18),
                              fontWeight: FontWeight.bold,
                            ),
                            "blockquote p": Style(
                              fontSize:
                                  FontSize((isAccessible) ? 22 * 1.2 : 22),
                              fontWeight: FontWeight.w700,
                              fontFamily: "GilroyMedium",
                              color: Colors.black.withOpacity(0.8),
                            ),
                          },
                          onLinkTap: (url) => onUrlTap(url),
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
          ),
        );
      },
    );
  }

  onUrlTap(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

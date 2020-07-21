import 'dart:ui';
import 'package:app/src/blocs/accessibility/index.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/objects/local_article.dart';
import 'package:app/src/repositories/local_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool theme;
  bool isLiked = false;
  bool isFirstTime = true;
  AccessibilityBloc accessibilityBloc;

  @override
  void initState() {
    accessibilityBloc = BlocProvider.of<AccessibilityBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: NotificationListener(
        onNotification: (v) {
          if (v is ScrollUpdateNotification) {
            setState(() => top -= v.scrollDelta / 2);
            setState(() => topBody -= v.scrollDelta);
          }
        },
        child: Stack(
          children: [
            Positioned(
              top: top + 120,
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
              top: (110 + 290.0),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  padding: const EdgeInsets.only(top: 16),
                  width: double.maxFinite,
                  color: (!theme)
                      ? LightPalette().colors["${Palette.backgroundPrimary}"]
                      : DarkPalette()
                          .colors["${Palette.backgroundPrimary}"]
                          .withOpacity(0.4),
                  child: SafeArea(
                    bottom: false,
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
                              BlocBuilder<AccessibilityBloc, bool>(
                                builder: (context, isAccessible) {
                                  return TopIcon(
                                      icon: FeatherIcons.shield,
                                      color:
                                          (isAccessible) ? Colors.blue : null,
                                      onClick: (isAccessible)
                                          ? () {
                                              accessibilityBloc
                                                ..add(ChangeAccessibleMode(
                                                    false));
                                            }
                                          : () {
                                              accessibilityBloc
                                                ..add(
                                                    ChangeAccessibleMode(true));
                                            });
                                },
                              ),
                              FutureBuilder(
                                future: LocalFeedRepository()
                                    .getArticle(widget.post.id),
                                builder: (context, snapshot) {
                                  return TopIcon(
                                    icon: FeatherIcons.heart,
                                    color: (isLiked || snapshot.hasData)
                                        ? Colors.red
                                        : (!theme)
                                            ? LightPalette().colors[
                                                '${Palette.textPrimary}']
                                            : DarkPalette().colors[
                                                '${Palette.textPrimary}'],
                                    onClick: () async {
                                      var result = await LocalFeedRepository()
                                          .getArticle(widget.post.id);
                                      print(result);
                                      if (result == null)
                                        insertLike();
                                      else
                                        removeLike();
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
    if (result == null) {
      setState(() {
        isLiked = false;
        isFirstTime = false;
      });
      return false;
    } else {
      print('New Article inserted: $result');
      setState(() {
        isLiked = true;
        isFirstTime = false;
      });
      return true;
    }
  }

  Future<bool> removeLike() async {
    var result = await LocalFeedRepository().delete(widget.post.id);
    if (result == null) {
    } else {
      print('Pinned Article removed: $result');
      setState(() {
        isLiked = false;
        isFirstTime = false;
      });
      return true;
    }
  }
}

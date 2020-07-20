import 'dart:io';
import 'dart:ui';
import 'package:app/src/blocs/accessibility/index.dart';
import 'package:app/src/components/zefyr/zefyr.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/objects/local_article.dart';
import 'package:app/src/objects/place.dart';
import 'package:app/src/pages/notes/editor/action_bar/action_bar.dart';
import 'package:app/src/repositories/local_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:share/share.dart';
import 'package:webfeed/domain/atom_item.dart';
import './content.dart';
import 'dart:convert';

class Body extends StatefulWidget {
  Place place;
  Body({Key key, @required this.place}) : super(key: key);

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

  Future<NotusDocument> loadDocument() async {
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    if (await file.exists()) {
      final contents = await file.readAsString();
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    final Delta delta = Delta()..insert("${widget.place.name}\n");
    return NotusDocument.fromDelta(delta);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: FutureBuilder<NotusDocument>(
        //initialData: initDoc,
        future: loadDocument(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return Center(
              child: Text(
                'Loading',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            );
          }
          return Stack(
            children: [
              Content(
                place: widget.place,
                document: snapshot.data,
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
                                  onClick: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //ActionBar(),
            ],
          );
        },
      ),
    );
  }
}

import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/feed/placeholder.dart';
import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:app/src/blocs/new_note/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import './place.dart';
import './bottom_loader.dart';
import './header.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  NewNoteBloc newNoteBloc;
  List<Widget> placeholderWidgets;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    newNoteBloc = BlocProvider.of<NewNoteBloc>(context);

    placeholderWidgets = List();
    for (int i = 0; i < 10; i++) {
      placeholderWidgets.add(ArticlePlaceholder());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewNoteBloc, NewNoteState>(
      builder: (context, state) {
        if (state is Uninitialized) {
          return ListView(
            children: [
              Header(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: CircularProgressIndicator(),
                        ),
                        BlocBuilder<LanguageBloc, Language>(
                          builder: (context, lang) {
                            return CText(
                              '${lang.script['feed_loading']}',
                              size: 24,
                              weight: FontWeight.bold,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: placeholderWidgets,
                  ),
                ],
              ),
            ],
          );
        }
        if (state is Error) {
          return LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            showChildOpacityTransition: false,
            animSpeedFactor: 4,
            color: Color(0xFFA92217),
            height: 100,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
              },
              child: ListView(
                children: [
                  Header(),
                  Expanded(
                    child: Center(
                      child: BlocBuilder<LanguageBloc, Language>(
                        builder: (context, lang) {
                          return CText(
                            '${lang.script['feed_failed']}',
                            size: 24,
                            weight: FontWeight.bold,
                          );
                        },
                      ),
                    ),
                  ),
                ], //failed to fetch posts
              ),
            ),
          );
        }
        if (state is Loaded) {
          if (state.places.isEmpty) {
            return ListView(
              children: [
                Header(),
                Expanded(
                  child: Center(
                    child: BlocBuilder<LanguageBloc, Language>(
                      builder: (context, lang) {
                        return CText(
                          '${lang.script['feed_empty']}',
                          size: 24,
                          weight: FontWeight.bold,
                        );
                      },
                    ), //no post
                  ),
                ),
              ],
            );
          }
          return LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            showChildOpacityTransition: false,
            animSpeedFactor: 4,
            color: Color(0xFFA92217),
            height: 100,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
              },
              child: ListView.builder(
                addAutomaticKeepAlives: true,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(),
                        CText(
                          'Vicini a te',
                          size: 16,
                          weight: FontWeight.normal,
                          color: Palette.textPrimary,
                          hPadding: 24,
                          top: 40,
                        ),
                      ],
                    );
                  return index >= state.places.length
                      ? BottomLoader()
                      : PlaceWidget(
                          place: state.places[index],
                        );
                },
                itemCount: state.hasReachedMax
                    ? state.places.length
                    : state.places.length + 1,
                controller: _scrollController,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      newNoteBloc.add(Fetch());
    }
  }

  Future<void> _handleRefresh() async {
    newNoteBloc..add(Restart());
    await Future.delayed(Duration(milliseconds: 500));
    return;
  }
}

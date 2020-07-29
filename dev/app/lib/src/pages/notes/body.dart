import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/blocs/notes/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/feed/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import './note.dart';
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
  NotesBloc newNoteBloc;
  List<Widget> placeholderWidgets;
  bool isInfinite = false;
  int index = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    newNoteBloc = BlocProvider.of<NotesBloc>(context);

    placeholderWidgets = List();
    for (int i = 0; i < 10; i++) {
      placeholderWidgets.add(ArticlePlaceholder());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesUninitialized) {
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
        if (state is NotesError) {
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
        if (state is NotesLoaded) {
          if (state.notes.isEmpty) {
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
                      child: BlocBuilder<LanguageBloc, Language>(
                        builder: (context, lang) {
                          return Container(
                            child: Wrap(
                              children: [
                                CText(
                                  '${lang.script['feed_empty']}',
                                  size: 24,
                                  weight: FontWeight.bold,
                                  top: 16,
                                  hPadding: 24,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state.notes.length >= index * 10) {
            isInfinite = true;
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
                padding: const EdgeInsets.only(bottom: 100),
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
                        NoteWidget(
                          note: state.notes[index],
                        ),
                      ],
                    );
                  return index >= state.notes.length
                      ? (index >= index * 10) ? BottomLoader() : Container()
                      : NoteWidget(
                          note: state.notes[index],
                        );
                },
                itemCount: state.hasReachedMax
                    ? state.notes.length
                    : state.notes.length + 1,
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
    print(isInfinite);
    if (isInfinite && maxScroll - currentScroll <= _scrollThreshold) {
      setState(() {
        index++;
      });
      newNoteBloc.add(Fetch());
    }
  }

  Future<void> _handleRefresh() async {
    newNoteBloc..add(Restart());
    await Future.delayed(Duration(milliseconds: 500));
    return;
  }
}

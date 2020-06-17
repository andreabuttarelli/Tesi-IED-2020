/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020

import 'package:flutter/material.dart';
import 'package:app/src/blocs/feed/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './article.dart';
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
  FeedBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<FeedBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state is FeedUninitialized) {
          return ListView(
            children: [
              Header(),
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        }
        if (state is FeedError) {
          return ListView(
            children: [
              Header(),
              Expanded(
                child: Center(
                  child: Text('failed to fetch posts'),
                ),
              ),
            ],
          );
        }
        if (state is FeedLoaded) {
          if (state.posts.isEmpty) {
            return ListView(
            children: [
              Header(),
              Expanded(
                child: Center(
                  child: Text('no posts'),
                ),
              ),
            ],
          );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) return Header();
              return index >= state.posts.length
                  ? BottomLoader()
                  : ArticleWidget(post: state.posts[index]);
            },
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            controller: _scrollController,
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
      _postBloc.add(Fetch());
    }
  }
}

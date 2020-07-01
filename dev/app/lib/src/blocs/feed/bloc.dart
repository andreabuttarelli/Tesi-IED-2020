/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020

import 'dart:async';
import 'dart:convert';

import 'package:app/src/objects/article.dart';
import 'package:app/src/repositories/feed.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './index.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final http.Client httpClient;
  int index = 1;
  int lang = 1;

  FeedBloc({@required this.httpClient});

  @override
  get initialState => FeedUninitialized();

  @override
  Stream<Transition<FeedEvent, FeedState>> transformEvents(
    Stream<FeedEvent> events,
    TransitionFunction<FeedEvent, FeedState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is FeedUninitialized) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          lang = prefs.getInt('lang');
          if (lang == null) lang = 1;
          final feed = await FeedRepositories().fetchPosts(index, lang);
          index++;
          yield FeedLoaded(posts: feed.items, hasReachedMax: false);
          return;
        }
        if (currentState is FeedLoaded) {
          final feed = await FeedRepositories().fetchPosts(index, lang);
          index++;
          yield feed.items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : FeedLoaded(
                  posts: currentState.posts + feed.items,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield FeedError();
      }
    }
  }

  bool _hasReachedMax(FeedState state) =>
      state is FeedLoaded && state.hasReachedMax;
}

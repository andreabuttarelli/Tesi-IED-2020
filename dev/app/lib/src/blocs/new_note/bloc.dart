import 'dart:async';
import 'dart:convert';
import 'package:app/src/objects/article.dart';
import 'package:app/src/repositories/feed.dart';
import 'package:app/src/repositories/notes.dart';
import 'package:app/src/repositories/position.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './index.dart';

class NewNoteBloc extends Bloc<NewNotesEvent, NewNoteState> {
  int index = 1;
  int lang = 1;

  NewNoteBloc();

  @override
  get initialState => Uninitialized();

  @override
  Stream<Transition<NewNotesEvent, NewNoteState>> transformEvents(
    Stream<NewNotesEvent> events,
    TransitionFunction<NewNotesEvent, NewNoteState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<NewNoteState> mapEventToState(NewNotesEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is Uninitialized) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          lang = prefs.getInt('lang');
          if (lang == null) lang = 1;
          final places = await PositionRepository().getAllPlaces();
          index++;
          yield Loaded(places: places, hasReachedMax: false);
          return;
        }
        if (currentState is Loaded) {
          final places = await PositionRepository().getAllPlaces();
          index++;
          yield places.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : Loaded(
                  places: currentState.places + places,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield Error();
      }
    }

    if (event is Restart) {
      yield Uninitialized();
      index = 0;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      lang = prefs.getInt('lang');
      if (lang == null) lang = 1;
      final places = await PositionRepository().getAllPlaces();
      index++;
      yield Loaded(places: places, hasReachedMax: false);
      return;
    }
  }

  bool _hasReachedMax(NewNoteState state) =>
      state is Loaded && state.hasReachedMax;
}

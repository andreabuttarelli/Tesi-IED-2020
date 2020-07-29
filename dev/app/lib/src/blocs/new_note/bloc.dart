import 'dart:async';
import 'package:app/src/repositories/position.dart';
import 'package:bloc/bloc.dart';
import './index.dart';

class NewNoteBloc extends Bloc<NewNotesEvent, NewNoteState> {
  int index = 1;
  int lang = 1;
  PositionRepository repository = PositionRepository();

  NewNoteBloc();

  @override
  get initialState => Uninitialized();

  @override
  Stream<NewNoteState> mapEventToState(NewNotesEvent event) async* {
    final currentState = state;
    if (event is FetchPlaces && !_hasReachedMax(currentState)) {
      try {
        if (currentState is Uninitialized) {
          final places = await repository.getAllPlaces();
          index++;
          yield Loaded(places: places, hasReachedMax: false);
          return;
        }
        if (currentState is Loaded) {
          final places = await repository.getAllPlaces();
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
      final places = await repository.getAllPlaces();
      index++;
      yield Loaded(places: places, hasReachedMax: false);
      return;
    }

    if (event is Search) {
      if (event.query != '') {
        final places = await repository.getPlacesByName(event.query);
        yield Loaded(places: places, hasReachedMax: false);
      } else {
        final places = await repository.getAllPlaces();
        yield Loaded(places: places, hasReachedMax: false);
      }
    }
  }

  bool _hasReachedMax(NewNoteState state) =>
      state is Loaded && state.hasReachedMax;
}

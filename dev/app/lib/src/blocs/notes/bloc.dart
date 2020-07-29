import 'dart:async';
import 'package:app/src/repositories/notes.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import './index.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  int index = 1;
  int lang = 1;

  NotesBloc();

  @override
  get initialState => NotesUninitialized();

  @override
  Stream<Transition<NotesEvent, NotesState>> transformEvents(
    Stream<NotesEvent> events,
    TransitionFunction<NotesEvent, NotesState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is NotesUninitialized) {
          final notes = await LocalNotesRepository().getNotes(index);
          index++;
          yield NotesLoaded(
              notes: (notes.length > 0) ? notes : [], hasReachedMax: false);
          return;
        }
        if (currentState is NotesLoaded) {
          final notes = await LocalNotesRepository().getNotes(index);
          index++;
          yield notes.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : NotesLoaded(
                  notes: currentState.notes + notes,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield NotesError();
      }
    }

    if (event is Restart) {
      yield NotesUninitialized();
      index = 0;
      final notes = await LocalNotesRepository().getNotes(index);
      index++;
      yield NotesLoaded(notes: notes, hasReachedMax: false);
      return;
    }
  }

  bool _hasReachedMax(NotesState state) =>
      state is NotesLoaded && state.hasReachedMax;
}

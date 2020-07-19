import 'package:app/src/objects/local_note.dart';
import 'package:app/src/objects/place.dart';
import 'package:equatable/equatable.dart';

abstract class NewNoteState extends Equatable {
  const NewNoteState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends NewNoteState {}

class Error extends NewNoteState {}

class Loaded extends NewNoteState {
  final List<Place> places;
  final bool hasReachedMax;

  const Loaded({
    this.places,
    this.hasReachedMax,
  });

  Loaded copyWith({
    List<LocalNote> places,
    bool hasReachedMax,
  }) {
    return Loaded(
      places: places ?? this.places,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [places, hasReachedMax];

  @override
  String toString() =>
      'NotesLoaded { places: ${places.length}, hasReachedMax: $hasReachedMax }';
}

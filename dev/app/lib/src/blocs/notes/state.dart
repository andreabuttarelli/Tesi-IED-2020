import 'package:app/src/objects/local_note.dart';
import 'package:equatable/equatable.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesUninitialized extends NotesState {}

class NotesError extends NotesState {}

class NotesLoaded extends NotesState {
  final List<LocalNote> notes;
  final bool hasReachedMax;

  const NotesLoaded({
    this.notes,
    this.hasReachedMax,
  });

  NotesLoaded copyWith({
    List<LocalNote> notes,
    bool hasReachedMax,
  }) {
    return NotesLoaded(
      notes: notes ?? this.notes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [notes, hasReachedMax];

  @override
  String toString() =>
      'NotesLoaded { notes: ${notes.length}, hasReachedMax: $hasReachedMax }';
}

import 'package:equatable/equatable.dart';

abstract class NotesEvent extends Equatable {
  NotesEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends NotesEvent {}

class Restart extends NotesEvent {}

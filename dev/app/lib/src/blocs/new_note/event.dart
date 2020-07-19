import 'package:equatable/equatable.dart';

abstract class NewNotesEvent extends Equatable {
  NewNotesEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends NewNotesEvent {}

class Restart extends NewNotesEvent {}

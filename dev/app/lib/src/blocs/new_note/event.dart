import 'package:equatable/equatable.dart';

abstract class NewNotesEvent extends Equatable {
  NewNotesEvent();

  @override
  List<Object> get props => [];
}

class FetchPlaces extends NewNotesEvent {}

class Restart extends NewNotesEvent {}

class Search extends NewNotesEvent {
  final String query;

  Search({this.query});
}

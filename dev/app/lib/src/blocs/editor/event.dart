import 'package:app/src/objects/place.dart';
import 'package:equatable/equatable.dart';

abstract class EditorEvent extends Equatable {
  EditorEvent();

  @override
  List<Object> get props => [];
}

class Update extends EditorEvent {
  final Place place;

  Update(this.place);

  @override
  String toString() => 'Update { place: $place }';
}

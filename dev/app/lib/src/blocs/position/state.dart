import 'package:app/src/objects/place.dart';
import 'package:equatable/equatable.dart';

abstract class PositionState extends Equatable {
  PositionState();

  @override
  List<Object> get props => [];
}

class Null extends PositionState {}

class PlaceFound extends PositionState {
  final Place place;

  PlaceFound({this.place});
}

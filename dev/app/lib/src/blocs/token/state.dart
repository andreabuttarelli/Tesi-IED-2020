import 'package:app/src/objects/place.dart';
import 'package:equatable/equatable.dart';

abstract class TokenState extends Equatable {
  TokenState();

  @override
  List<Object> get props => [];
}

class Null extends TokenState {}

class PlaceFound extends TokenState {
  final Place place;

  PlaceFound({this.place});
}

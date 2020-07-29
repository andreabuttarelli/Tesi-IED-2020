import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PositionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdatePosition extends PositionEvent {
  final GeoPoint geopoint;

  UpdatePosition({this.geopoint});
}

import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TokenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateTokenPosition extends TokenEvent {
  final GeoPoint geopoint;

  UpdateTokenPosition({this.geopoint});
}

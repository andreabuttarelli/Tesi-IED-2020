import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserEvent extends Equatable {
  UserEvent();

  List<Object> get props => [];

  @override
  String toString() => 'UserEvent';
}

class UserLogged extends UserEvent {

  UserLogged();

  List<Object> get props => [];

  @override
  String toString() => 'UserLogged { }';
}
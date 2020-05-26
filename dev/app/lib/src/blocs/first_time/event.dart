import 'package:equatable/equatable.dart';

abstract class FirstTimeEvent extends Equatable {
  FirstTimeEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'FirstTimeEvent { }';
}

class Started extends FirstTimeEvent { }

class Flaged extends FirstTimeEvent { }
/// MIT License
/// by Andrea Buttarelli
/// creato il 03/06/2020
/// aggiornato il 05/06/2020

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NavigationEvent extends Equatable {
  NavigationEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'NavigationEvent { }';
}

class ChangeIndex extends NavigationEvent {
  final int i;
  ChangeIndex({@required this.i});

  @override
  List<Object> get props => [i];

  @override
  String toString() => 'ChangeIndex { i: $i }';
}
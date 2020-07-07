import 'package:equatable/equatable.dart';

abstract class AlertEvent extends Equatable {
  AlertEvent();
}

class Show extends AlertEvent {
  Show();

  List<Object> get props => [];
}

class Hide extends AlertEvent {
  Hide();

  List<Object> get props => [];
}

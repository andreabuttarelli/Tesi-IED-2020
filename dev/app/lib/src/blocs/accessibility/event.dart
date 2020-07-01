import 'package:equatable/equatable.dart';

abstract class AccessibilityEvent extends Equatable {
  AccessibilityEvent();
}

class ChangeAccessibleMode extends AccessibilityEvent {
  bool value;

  ChangeAccessibleMode(this.value);

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'ChangeAccessibleMode { value: $value }';
}

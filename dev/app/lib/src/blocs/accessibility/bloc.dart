import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class AccessibilityBloc extends Bloc<AccessibilityEvent, bool> {
  AccessibilityBloc();

  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(AccessibilityEvent event) async* {
    if (event is ChangeAccessibleMode) {
      yield event.value;
    }
  }
}

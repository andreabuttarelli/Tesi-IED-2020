import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class AlertBloc extends Bloc<AlertEvent, bool> {
  AlertBloc();

  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(AlertEvent event) async* {
    if (event is Show) yield true;
    if (event is Hide) yield false;
  }
}

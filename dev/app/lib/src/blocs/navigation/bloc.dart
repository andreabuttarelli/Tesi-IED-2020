/// MIT License
/// by Andrea Buttarelli
/// creato il 03/06/2020
/// aggiornato il 05/06/2020

import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class NavigationBloc extends Bloc<NavigationEvent, int> {
  NavigationBloc();

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(NavigationEvent event) async* {
    if (event is ChangeIndex) {
      yield event.i;
    }
  }
}
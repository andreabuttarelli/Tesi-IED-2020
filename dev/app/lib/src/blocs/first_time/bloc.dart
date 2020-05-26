import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeBloc extends Bloc<FirstTimeEvent, FirstTimeState> {
  FirstTimeBloc();

  @override
  FirstTimeState get initialState => FirstTimeState.initializing;

  @override
  Stream<FirstTimeState> mapEventToState(FirstTimeEvent event) async* {
    if (event is Started) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool firstTime = prefs.getBool('first_time');

      var _duration = new Duration(seconds: 3);

      if (firstTime != null && !firstTime) {
        yield FirstTimeState.notFirstTime;
      } else {
        yield FirstTimeState.firstTime;
      }
    }

    if (event is Flaged) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('first_time', false);
      yield FirstTimeState.notFirstTime;
    }
  }
}

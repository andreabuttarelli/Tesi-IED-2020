import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './index.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeEnum> {
  ThemeBloc();

  @override
  ThemeEnum get initialState => null;

  @override
  Stream<ThemeEnum> mapEventToState(ThemeEvent event) async* {
    if (event is SwitchTheme) {
      print("hey");
      yield event.theme;
      var value = 0;
      if (event.theme == ThemeEnum.dark) value = 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var result = await prefs.setInt('theme', value);
      print("Saved changes theme color in local: $result");
    }
  }
}

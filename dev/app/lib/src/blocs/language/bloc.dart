/// MIT License
/// by Andrea Buttarelli
/// creato il 03/06/2020
/// aggiornato il 03/06/2020

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './index.dart';

class LanguageBloc extends Bloc<LanguageEvent, Language> {
  LanguageBloc();

  @override
  Language get initialState => English();

  @override
  Stream<Language> mapEventToState(LanguageEvent event) async* {
    if (event is LanguageBlocStarted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int lang = prefs.getInt('lang');

      if (lang != null) {
        switch (lang) {
          case 0:
            yield Italian();
            break;
          case 1:
            yield English();
            break;
          case 2:
            yield Spanish();
            break;
          case 3:
            yield Chinese();
            break;
          default:
            yield English();
            break;
        }
      } else {
        yield Spanish();
      }
    }

    if (event is ChangeLanguage) {
      int index;
      if (event.lang is Italian)
        index = 0;
      else if (event.lang is English)
        index = 1;
      else if (event.lang is Spanish)
        index = 2;
      else if (event.lang is Chinese) index = 3;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('lang', index);
      yield event.lang;
    }
  }
}

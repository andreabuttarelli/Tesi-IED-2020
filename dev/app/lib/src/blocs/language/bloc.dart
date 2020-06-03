/// MIT License
/// by Andrea Buttarelli
/// creato il 03/06/2020
/// aggiornato il 03/06/2020

import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class LanguageBloc extends Bloc<LanguageEvent, Language> {
  LanguageBloc();

  @override
  Language get initialState => Language.en;

  @override
  Stream<Language> mapEventToState(LanguageEvent event) async* {
    if (event is ChangeLanguage) yield event.lang;
  }
}
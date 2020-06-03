/// MIT License
/// by Andrea Buttarelli
/// creato il 03/06/2020
/// aggiornato il 03/06/2020

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:app/src/blocs/language/state.dart';

abstract class LanguageEvent extends Equatable {
  LanguageEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LanguageEvent { }';
}

class ChangeLanguage extends LanguageEvent {
  Language lang;
  ChangeLanguage({@required this.lang});

  @override
  List<Object> get props => [lang];

  @override
  String toString() => 'ChangeLanguage { lang: ${lang.toString()} }';
}
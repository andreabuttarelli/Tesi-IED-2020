/// MIT License
/// by Andrea Buttarelli
/// creato il 03/06/2020
/// aggiornato il 03/06/2020

/*enum Language {
  it,
  en,
  ch,
  es,
}*/

import 'package:equatable/equatable.dart';

abstract class Language extends Equatable {
  Map<String, String> script = {};
  Language();
}

class Italian extends Language {
  Map<String, String> script = {
    "feed_title": "News",
    "feed_subtitle": "Tutte le ultime notizie, per te.",
    "feed_loading": "Caricamento",
    "feed_failed": "Impossibile recuperare i post",
    "feed_empty": "Sembra vuoto",
    "banner_covid_title": "Insieme ce la faremo",
  };

  Italian();

  @override
  List<Object> get props => [];
}

class English extends Language {
  Map<String, String> script = {
    "feed_title": "News",
    "feed_subtitle": "All the latest news, for you.",
    "feed_loading": "Loading",
    "feed_failed": "Failed to fetch posts",
    "feed_empty": "It looks empty",
    "banner_covid_title": "Together we will do it",
  };

  English();

  @override
  List<Object> get props => [];
}

class Spanish extends Language {
  Map<String, String> script = {
    "feed_title": "News",
    "feed_subtitle": "Todas las últimas noticias, para ti.",
    "feed_loading": "Cargando",
    "feed_failed": "Error al recuperar publicaciones",
    "feed_empty": "Se ve vacio",
    "banner_covid_title": "Juntos lo haremos",
  };

  Spanish();

  @override
  List<Object> get props => [];
}

class Chinese extends Language {
  Map<String, String> script = {
    "feed_title": "新闻",
    "feed_subtitle": "所有最新消息，为您服务。",
    "feed_loading": "载入中",
    "feed_failed": "无法提取帖子",
    "feed_empty": "看起来很空",
    "banner_covid_title": "我们将共同努力",
  };

  Chinese();

  @override
  List<Object> get props => [];
}

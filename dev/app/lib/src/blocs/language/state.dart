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
    "close": "Chiudi",
    "back": "Indietro",
    "feed_title": "Notizie",
    "feed_subtitle": "Tutte le ultime notizie, per te.",
    "feed_loading": "Caricamento",
    "feed_failed": "Impossibile recuperare i post",
    "feed_empty": "Sembra vuoto",
    "feed_profile_notlogged": "login",
    "feed_profile_logged": "profilo",
    "banner_covid_title": "Insieme ce la faremo",
    "profile_title": "Profilo",
    "notes_title": "Prendi Nota",
    "notes_subtitle": "Perchè non è sempre possibile ricordarsi tutto.",
    "change_language_title": "Cambia la lingua",
    "noar_arcore":
        "Siamo spiacenti, il tuo telefono non supporta le funzionalità di ArCore",
    "noar_arkit":
        "Siamo spiacenti, il tuo telefono non supporta le funzionalità di ArKit",
  };

  Italian();

  @override
  List<Object> get props => [];
}

class English extends Language {
  Map<String, String> script = {
    "close": "Close",
    "back": "Back",
    "feed_title": "News",
    "feed_subtitle": "All the latest news, for you.",
    "feed_loading": "Loading",
    "feed_failed": "Failed to fetch posts",
    "feed_empty": "It looks empty",
    "feed_profile_notlogged": "login",
    "feed_profile_logged": "profile",
    "banner_covid_title": "Together we will do it",
    "profile_title": "Profile",
    "notes_title": "Notes",
    "notes_subtitle": "It is not always possible to remember everything.",
    "change_language_title": "Change language",
    "noar_arcore": "Sorry, your phone doesn't support ArCore features",
    "noar_arkit": "Sorry, your phone doesn't support ArKit features",
  };

  English();

  @override
  List<Object> get props => [];
}

class Spanish extends Language {
  Map<String, String> script = {
    "close": "Cierra",
    "back": "Atras",
    "feed_title": "News",
    "feed_subtitle": "Todas las últimas noticias, para ti.",
    "feed_loading": "Cargando",
    "feed_failed": "Error al recuperar publicaciones",
    "feed_empty": "Se ve vacio",
    "feed_profile_notlogged": "login",
    "feed_profile_logged": "perfil",
    "banner_covid_title": "Juntos lo haremos",
    "profile_title": "Perfil",
    "notes_title": "Tomar nota",
    "notes_subtitle": "Porque no siempre es posible recordarlo todo.",
    "change_language_title": "Cambiar idioma",
    "noar_arcore":
        "Lo sentimos, su teléfono no es compatible con las funciones de ArCore",
    "noar_arkit":
        "Lo sentimos, su teléfono no es compatible con las funciones de ArKit",
  };

  Spanish();

  @override
  List<Object> get props => [];
}

class Chinese extends Language {
  Map<String, String> script = {
    "close": "关闭",
    "back": "背部",
    "feed_title": "新闻",
    "feed_subtitle": "所有最新消息，为您服务。",
    "feed_loading": "载入中",
    "feed_failed": "无法提取帖子",
    "feed_empty": "看起来很空",
    "feed_profile_notlogged": "登录",
    "feed_profile_logged": "个人资料",
    "banner_covid_title": "我们将共同努力",
    "profile_title": "个人资料",
    "notes_title": "做记录",
    "notes_subtitle": "因为并非总是能够记住所有事情",
    "change_language_title": "改变语言",
    "noar_arcore": "抱歉，您的手机不支持ArCore功能",
    "noar_arkit": "抱歉，您的手机不支持ArKit功能",
  };

  Chinese();

  @override
  List<Object> get props => [];
}

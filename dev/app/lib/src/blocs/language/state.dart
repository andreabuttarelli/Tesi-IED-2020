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
    "profile_token_title": "Adesso tocca a te lasciare il segno.",
    "profile_token_found": "Token trovati",
    "profile_favorites_title": "Favoriti",
    "profile_favorites_subtitle": "Qui puoi trovare tutti gli articoli salvati",
    "notes_title": "Prendi Nota",
    "notes_subtitle": "Perchè non è sempre possibile ricordarsi tutto.",
    "change_language_title": "Cambia la lingua",
    "noar_arcore":
        "Siamo spiacenti, il tuo telefono non supporta le funzionalità di ArCore",
    "noar_arkit":
        "Siamo spiacenti, il tuo telefono non supporta le funzionalità di ArKit",
    "open_camera": "Apri la fotocamera",
    "settings_title": "Impostazioni",
    "settings_change_email": "Cambia Email",
    "settings_change_password": "Reimposta Password",
    "settings_change_lang": "Cambia Lingua",
    "settings_logout": "Esci",
    "settings_delete_account": "Elimina Account",
    "accessible_mode_title": "Modalità Accessibile",
    "accessible_mode_description":
        "Testi più grandi per una migliore leggibilità",
    "accessible_mode_try": "Prova ora",
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
    "profile_token_title": "Now it's your turn to leave your mark in history.",
    "profile_token_found": "Tokens found",
    "profile_favorites_title": "Favorites",
    "profile_favorites_subtitle": "Here you can find all your pinned articles",
    "notes_title": "Notes",
    "notes_subtitle": "It is not always possible to remember everything.",
    "change_language_title": "Change language",
    "noar_arcore": "Sorry, your phone doesn't support ArCore features",
    "noar_arkit": "Sorry, your phone doesn't support ArKit features",
    "open_camera": "Open camera",
    "settings_title": "Settings",
    "settings_change_email": "Change Email",
    "settings_change_password": "Change Password",
    "settings_change_lang": "Change Language",
    "settings_logout": "Logout",
    "settings_delete_account": "Delete Account",
    "accessible_mode_title": "Accessible Mode",
    "accessible_mode_description": "Larger texts for better readability",
    "accessible_mode_try": "Try now",
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
    "profile_token_title": "Ahora es tu turno de dejar tu huella.",
    "profile_token_found": "Fichas encontradas",
    "profile_favorites_title": "Favoritos",
    "profile_favorites_subtitle":
        "Aquí puedes encontrar todos tus artículos anclados",
    "notes_title": "Tomar nota",
    "notes_subtitle": "Porque no siempre es posible recordarlo todo.",
    "change_language_title": "Cambiar idioma",
    "noar_arcore":
        "Lo sentimos, su teléfono no es compatible con las funciones de ArCore",
    "noar_arkit":
        "Lo sentimos, su teléfono no es compatible con las funciones de ArKit",
    "open_camera": "Abrir la cámara", //TODO
    "settings_title": "Configuraciones",
    "settings_change_email": "Cambiar e-mail",
    "settings_change_password": "Restablecer la contraseña",
    "settings_change_lang": "Cambiar idioma",
    "settings_logout": "Logout",
    "settings_delete_account": "Borrar cuenta",
    "accessible_mode_title": "Modo accesible",
    "accessible_mode_description":
        "Textos más grandes para una mejor legibilidad.",
    "accessible_mode_try": "Probar ahora",
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
    "profile_token_title": "现在该轮到你留下印记了。",
    "profile_token_found": "找到代币",
    "profile_favorites_title": "收藏夹",
    "profile_favorites_subtitle": "在这里您可以找到所有固定的文章",
    "notes_title": "做记录",
    "notes_subtitle": "因为并非总是能够记住所有事情",
    "change_language_title": "改变语言",
    "noar_arcore": "抱歉，您的手机不支持ArCore功能",
    "noar_arkit": "抱歉，您的手机不支持ArKit功能",
    "open_camera": "打开照相机",
    "settings_title": "设定值",
    "settings_change_email": "更改电子邮件",
    "settings_change_password": "重设密码",
    "settings_change_lang": "改变语言",
    "settings_logout": "出去",
    "settings_delete_account": "删除帐户",
    "accessible_mode_title": "无障碍模式",
    "accessible_mode_description": "较大的文字可提高可读性",
    "accessible_mode_try": "现在试试",
  };

  Chinese();

  @override
  List<Object> get props => [];
}

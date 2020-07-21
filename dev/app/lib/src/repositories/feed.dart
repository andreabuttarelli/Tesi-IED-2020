import 'package:hive/hive.dart';
import 'package:webfeed/domain/atom_feed.dart';
import 'package:http/http.dart' as http;

/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 28/06/2020

class FeedRepositories {
  final http.Client httpClient;

  FeedRepositories({this.httpClient});

  Future<AtomFeed> fetchPosts(int index, int lang) async {
    //Dio dio;

    var prefix = '';
    if (lang == 1)
      prefix = 'en/';
    else if (lang == 2)
      prefix = 'es/';
    else if (lang == 3) prefix = 'zh-hans/';
    var _targetUrl = 'https://parcocolosseo.it/${prefix}feed/atom?page=';

    await Hive.openBox('feedNews');

    return await http.read('$_targetUrl$index').then((xmlString) {
      saveXML(xmlString);
      return AtomFeed.parse(xmlString);
    });
  }

  saveXML(String xmlString) async {
    var feed = Hive.box('feedNews');
    feed.put('xml', xmlString);
  }
}

import 'package:webfeed/domain/atom_feed.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:http/http.dart' as http;

/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 28/06/2020

class FeedRepositories {
  final http.Client httpClient;
  final _targetUrl = 'https://parcocolosseo.it/feed/atom?page=';

  FeedRepositories({this.httpClient});

  Future<AtomFeed> fetchPosts(int index) async {
    return await http
        .read('$_targetUrl$index')
        .then((xmlString) => AtomFeed.parse(xmlString));
  }
}

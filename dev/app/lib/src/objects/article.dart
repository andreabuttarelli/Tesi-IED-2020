/// MIT License
/// by Andrea Buttarelli
/// creato il 26/05/2020
/// modificato il 26/05/2020

import 'package:equatable/equatable.dart';

class ArticleObject extends Equatable {
  final int id;
  final String title;
  final String body;

  const ArticleObject({this.id, this.title, this.body});

  @override
  List<Object> get props => [id, title, body];

  @override
  String toString() => 'ArticleObject { id: $id }';
}
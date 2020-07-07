import 'package:app/src/repositories/local_feed.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:meta/meta.dart';

final ColumnNames columnNames = ColumnNames();

class LocalArticle {
  String id;
  String title;
  String image;
  String category;
  String date;
  String content;
  String link;

  LocalArticle({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.category,
    @required this.date,
    @required this.content,
    @required this.link,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnNames.columnId: id,
      columnNames.columnTitle: title,
      columnNames.columnImage: image,
      columnNames.columnCategory: category,
      columnNames.columnContent: content,
      columnNames.columnDate: date,
      columnNames.columnLink: link,
    };
    return map;
  }

  LocalArticle.fromMap(Map<String, dynamic> map) {
    id = map[columnNames.columnId];
    title = map[columnNames.columnTitle];
    image = map[columnNames.columnImage];
    category = map[columnNames.columnCategory];
    content = map[columnNames.columnContent];
    date = map[columnNames.columnDate];
    link = map[columnNames.columnLink];
  }
}

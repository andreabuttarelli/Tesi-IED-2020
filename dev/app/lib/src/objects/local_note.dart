import 'package:app/src/repositories/notes.dart';
import 'package:meta/meta.dart';

final ColumnNames columnNames = ColumnNames();

class LocalNote {
  int nid;
  String id;
  String title;
  String image;
  String date;
  String content;

  LocalNote({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.date,
    @required this.content,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnNames.columnId: id,
      columnNames.columnTitle: title,
      columnNames.columnImage: image,
      columnNames.columnContent: content,
      columnNames.columnDate: date,
    };
    return map;
  }

  LocalNote.fromMap(Map<String, dynamic> map) {
    nid = map["id"];
    id = map[columnNames.columnId];
    title = map[columnNames.columnTitle];
    image = map[columnNames.columnImage];
    content = map[columnNames.columnContent];
    date = map[columnNames.columnDate];
  }
}

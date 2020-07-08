import 'package:app/src/objects/local_article.dart';
import 'package:sqflite/sqflite.dart';

class ColumnNames {
  final String tableLocalFeed = 'localFeed';
  final String columnId = 'article_id';
  final String columnImage = 'image';
  final String columnTitle = 'title';
  final String columnContent = 'content';
  final String columnLink = 'link';
  final String columnDate = 'date';
  final String columnCategory = 'category';
}

class LocalFeedRepository {
  Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath' '${columnNames.tableLocalFeed}.db';
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table ${columnNames.tableLocalFeed} ( 
  id integer primary key autoincrement, 
  ${columnNames.columnId} text not null unique,
  ${columnNames.columnTitle} text not null,
  ${columnNames.columnImage} text not null,
  ${columnNames.columnCategory} text not null,
  ${columnNames.columnContent} text not null,
  ${columnNames.columnDate} text not null,
  ${columnNames.columnLink} text not null)
''');
    });
  }

  Future<int> insert(LocalArticle article) async {
    await open();
    int id = await db.insert(columnNames.tableLocalFeed, article.toMap());
    return id;
  }

  Future<LocalArticle> getArticle(String id) async {
    await open();
    List<Map> maps = await db.query(columnNames.tableLocalFeed,
        columns: [
          columnNames.columnId,
          columnNames.columnTitle,
          columnNames.columnImage,
          columnNames.columnCategory,
          columnNames.columnContent,
          columnNames.columnDate,
          columnNames.columnLink
        ],
        where: '${columnNames.columnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return LocalArticle.fromMap(maps.first);
    }
    return null;
  }

  Future<List<LocalArticle>> getArticles() async {
    await open();
    List<Map<String, dynamic>> records =
        await db.query('${columnNames.tableLocalFeed}');
    List<LocalArticle> articles = [];
    records.forEach((row) {
      articles.add(LocalArticle.fromMap(row));
    });
    return articles;
  }

  Future<int> delete(String id) async {
    await open();
    return await db.delete(columnNames.tableLocalFeed,
        where: '${columnNames.columnId} = ?', whereArgs: [id]);
  }

  Future<int> update(LocalArticle article) async {
    await open();
    return await db.update(columnNames.tableLocalFeed, article.toMap(),
        where: '${columnNames.columnId} = ?', whereArgs: [article.id]);
  }

  Future close() async => db.close();
}

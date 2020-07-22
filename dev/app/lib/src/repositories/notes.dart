import 'dart:io';

import 'package:app/src/objects/local_note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ColumnNames {
  final String tableLocalFeed = 'localNotes';
  final String columnId = 'note_id';
  final String columnImage = 'image';
  final String columnTitle = 'title';
  final String columnContent = 'content';
  final String columnDate = 'date';
}

class LocalNotesRepository {
  Database db;

  Future open() async {
    var documentDirectory = await getApplicationDocumentsDirectory();
    String path =
        join(documentDirectory.path, '${columnNames.tableLocalFeed}.db');
    if (await Directory(dirname(path)).exists()) {
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      return db.execute('''
create table ${columnNames.tableLocalFeed} ( 
  id integer primary key autoincrement, 
  ${columnNames.columnId} text unique,
  ${columnNames.columnTitle} text not null,
  ${columnNames.columnImage} text not null,
  ${columnNames.columnContent} text not null,
  ${columnNames.columnDate} text not null)
''');
    });
  }

  Future<int> insert(LocalNote note) async {
    await open();
    print(note.id);
    int id = await db.insert(columnNames.tableLocalFeed, note.toMap());
    return id;
  }

  Future<LocalNote> getNote(String id) async {
    await open();
    List<Map> maps = await db.query(columnNames.tableLocalFeed,
        columns: [
          columnNames.columnId,
          columnNames.columnTitle,
          columnNames.columnImage,
          columnNames.columnContent,
          columnNames.columnDate
        ],
        where: '${columnNames.columnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return LocalNote.fromMap(maps.first);
    }
    return null;
  }

  Future<List<LocalNote>> getNotes(int offset) async {
    await open();
    List<Map<String, dynamic>> records =
        await db.query('${columnNames.tableLocalFeed}');
    List<LocalNote> notes = [];
    records.forEach((row) {
      notes.add(LocalNote.fromMap(row));
    });
    return notes;
  }

  Future<int> delete(String id) async {
    await open();
    return await db.delete(columnNames.tableLocalFeed,
        where: '${columnNames.columnId} = ?', whereArgs: [id]);
  }

  Future<int> update(LocalNote note) async {
    await open();
    return await db.update(columnNames.tableLocalFeed, note.toMap(),
        where: '${columnNames.columnId} = ?', whereArgs: [note.id]);
  }

  Future close() async => db.close();
}

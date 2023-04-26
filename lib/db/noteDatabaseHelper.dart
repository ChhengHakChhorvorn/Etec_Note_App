import 'dart:io';

import 'package:note_app/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DatabaseStucture {
  Future<Database> initializeDatabase();
  Future<void> insertData(NoteModel noteModel);
  Future<void> updateData(NoteModel noteModel);
  Future<void> deleteData(int id);
  Future<List<NoteModel>> getNoteData();
}

class NoteDatabaseHelper extends DatabaseStucture {
  @override
  Future<void> deleteData(int id) async {
    final db = await initializeDatabase();
    await db.delete("notes", where: 'id=?', whereArgs: [id]);
  }

  @override
  Future<List<NoteModel>> getNoteData() async {
    var db = await initializeDatabase();
    List<Map<String, dynamic>> result = await db.query("notes");
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  @override
  Future<Database> initializeDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var databasesPath = await getDatabasesPath();
    String path = await getDatabasesPath();
    return openDatabase(join(path, 'noteApp.db'),
        onCreate: ((db, version) async {
      await db.execute('''CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          body TEXT,
          category TEXT,
          color TEXT,
          creationDate TEXT
           )''');
    }), version: 1);
  }

  @override
  Future<void> insertData(NoteModel noteModel) async {
    var db = await initializeDatabase();
    await db.insert("notes", noteModel.toMap());
  }

  @override
  Future<void> updateData(NoteModel noteModel) async {
    final db = await initializeDatabase();
    await db.update("notes", noteModel.toMap(),
        where: 'id=?', whereArgs: [noteModel.id]);
  }
}

import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/models/contact.dart';

class DbHelper {
  static late DbHelper _dbHelper;
  static late Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    _dbHelper = DbHelper._createObject();
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/contact.db';
    var contactDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return contactDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contact (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT
      )
    ''');
  }

  Future<Database> get database async {
    _database = await initDb();
    return _database;
  }

  // Create (C)
  Future<int> insert(Contact object) async {
    Database db = await database;
    return await db.insert('contact', object.toMap());
  }

  // Read (R)
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await database;
    return await db.query('contact', orderBy: 'name');
  }

  // Update (U)
  Future<int> update(Contact object) async {
    Database db = await database;
    return await db.update(
      'contact',
      object.toMap(),
      where: 'id = ?',
      whereArgs: [object.id],
    );
  }

  // Delete (D)
  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      'contact',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Convert map list to contact list
  Future<List<Contact>> getContactList() async {
    var contactMapList = await select();
    return contactMapList.map((map) => Contact.fromMap(map)).toList();
  }
}

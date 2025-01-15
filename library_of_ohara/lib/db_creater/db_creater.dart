import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbCreater {
  late Database db;

  Future<Database> createDB() async {
    sqfliteFfiInit();
    final currentDir = Directory.current;
    String dbPath =
        path.join(currentDir.path, "databases", "library_of_ohara.db");
    var databaseFactory = databaseFactoryFfi;
    db = await databaseFactory.openDatabase(
      dbPath,
    );
    setDB(db);
    return db;
  }

  void setDB(Database database) {
    db = database;
  }

  Future<Database> getDB() async {
    return db;
  }

  Future<void> crearUsuarios() async {
    db = await getDB();
     await db.execute('''
      CREATE TABLE IF NOT EXISTS usuario (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      gmail TEXT,
      contrasena TEXT
  )
  ''');
  }

  Future<void> crearLibros() async{
    db= await getDB();
    await db.execute('''
    CREATE TABLE IF NOT EXIST libro (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT,
    
    )
''');
  }
}

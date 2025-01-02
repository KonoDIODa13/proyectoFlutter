import 'dart:io';
import 'package:flutter/material.dart';
import 'package:library_of_ohara/model/usuario.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class UserProvider extends ChangeNotifier {
  late Usuario usuario;
  late Database db;

  UserProvider() {
    inicializarBD();
  }

  void inicializarBD() async {
    sqfliteFfiInit();
    final currentDir = Directory.current;

    //Create path for database
    String dbPath =
        path.join(currentDir.path, "databases", "library_of_ohara.db");
    var databaseFactory = databaseFactoryFfi;
    db = await databaseFactory.openDatabase(
      dbPath,
    );
    createDB(db);
    setDB(db);
    notifyListeners();
  }

  void createDB(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Usuario (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      gmail TEXT,
      contrasena TEXT
  )
  ''');
    print("creada la bd");
  }

  Future<bool> login(String nombre, String contra) async {
    var db = await getDB();
    bool encontrado = false;
    var query = await db.query("usuario");
    if (query.isNotEmpty) {
      var user = await db.query("usuario",
          where: "nombre= ? and pasword= ?", whereArgs: [nombre, contra]);
      if (user.isNotEmpty) {
        encontrado = true;
        setUsuario(Usuario.fromMap(user.first));
      }
    }
    return encontrado;
  }

  Future<bool> register(Usuario usuarioRegistro) async {
    var db = await getDB();
    bool creado = false;
    var query = await db.query("usuario");
    if (query.isNotEmpty) {
      var user = await db.query("usuario",
          where: "nombre= ? and pasword= ?",
          whereArgs: [
            usuarioRegistro.getNombre(),
            usuarioRegistro.getContrasena()
          ]);
      if (user.isEmpty) {
        insertarUsuario(usuarioRegistro);
        setUsuario(usuarioRegistro);
        creado = true;
      } else {
        print("usuario ya creado");
      }
    } else {
      insertarUsuario(usuarioRegistro);
      setUsuario(usuarioRegistro);
      creado = true;
    }
    return creado;
  }

  insertarUsuario(Usuario usuario) {
    db.insert("usuario", usuario.toMap());
  }

  setUsuario(Usuario user) {
    usuario = user;
  }

  getUser() {
    return usuario;
  }

  setDB(Database database) {
    db = database;
  }

  Future<Database> getDB() async {
    return db;
  }
}

import 'dart:io';
//import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:library_of_ohara/model/usuario.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class UserProvider extends ChangeNotifier {
  late Usuario? usuario;
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
      CREATE TABLE IF NOT EXISTS usuario (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      gmail TEXT,
      contrasena TEXT
  )
  ''');
  }

  Future<bool> login(String nombre, String contra) async {
    var db = await getDB();
    //var contrasenaCifrada = BCrypt.hashpw(contra, BCrypt.gensalt());
    bool encontrado = false;
    var query = await db.query("usuario");
    if (query.isNotEmpty) {
      var user = await db.query("usuario",
          where: "nombre= ? and contrasena= ?", whereArgs: [nombre, contra]);
      if (user.isNotEmpty) {
        encontrado = true;
        setUsuario(Usuario.fromMap(user.first));
      }
    }
    return encontrado;
  }

  Future<bool> register(Usuario usuarioRegistro) async {
    var db = await getDB();
    /*var contrasenaCifrada =
        BCrypt.hashpw(usuarioRegistro.getContrasena(), BCrypt.gensalt());
    usuarioRegistro.setContrasena(contrasenaCifrada);*/
    bool creado = false;
    var query = await db.query("usuario");
    if (query.isNotEmpty) {
      var user = await db.query("usuario",
          where: "nombre= ? and contrasena= ?",
          whereArgs: [
            usuarioRegistro.getNombre(),
            usuarioRegistro.getContrasena()
          ]);
      if (user.isEmpty) {
        insertarUsuario(usuarioRegistro);
        setUsuario(usuarioRegistro);
        creado = true;
      }
    } else {
      insertarUsuario(usuarioRegistro);
      setUsuario(usuarioRegistro);
      creado = true;
    }
    return creado;
  }

  insertarUsuario(Usuario user) {
    db.insert("usuario", user.toMap());
  }

  setUsuario(Usuario? user) {
    if (user == null) {
      usuario = null;
    } else {
      usuario = user;
    }
    notifyListeners();
  }

  getUser() {
    return usuario!;
  }

  setDB(Database database) {
    db = database;
  }

  Future<Database> getDB() async {
    return db;
  }

  cerrarSesion() {
    setUsuario(null);
    notifyListeners();
  }
}

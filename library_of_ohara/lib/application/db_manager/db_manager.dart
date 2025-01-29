import 'dart:io';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:path/path.dart' as path;

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbManager {
  late Database db;

  String getDBPath() {
    final currentDir = Directory.current;
    String dbPath =
        path.join(currentDir.path, "databases", "library_of_ohara.db");
    return dbPath;
  }

  Future<Database> openDB() async {
    sqfliteFfiInit();
    var path = getDBPath();
    var databaseFactory = databaseFactoryFfi;
    db = await databaseFactory.openDatabase(
      path,
    );
    createDBUsuario();
    return db;
  }

  Future<Database> getDB() async {
    return db;
  }

  void setDB(Database database) {
    db = database;
  }

  Future<void> createDBUsuario() async {
    db = await getDB();
    await db.execute('''
      CREATE TABLE IF NOT EXISTS usuario (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      gmail TEXT,
      contrasena TEXT,
      imagen TEXT
  )
  ''');
  }

  Future<void> crearDBLibros() async {
    db = await getDB();
    // debido a la falta de tiempo, de momento tanto el autor como genero son
    // de tipo texto y no una clase como tal.
    // ademas, la fecha de publicacion es texto aunque trabaje con ella como si fuera
    // un datetime.
    await db.execute('''
    CREATE TABLE IF NOT EXISTS libro (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT,
    autor TEXT, 
    genero TEXT,
    ISBN TEXT,
    descripcion TEXT,
    fechaPublicacion TEXT
    )
''');
  }

  Future<bool> compruebaUsuario(String nombre, String contra) async {
    bool existe = false;
    var query = await db.query("usuario",
        where: "nombre= ? and contrasena=?", whereArgs: [nombre, contra]);
    if (query.isNotEmpty) {
      existe = true;
    }
    return existe;
  }

  Future<Usuario?> login(String nombre, String contra) async {
    Usuario? usuario;
    if (await compruebaUsuario(nombre, contra)) {
      usuario = await getUsuario(nombre);
    }
    return usuario;
  }

  Future<Usuario?> register(Usuario usuarioRegister) async {
    Usuario? usuario;
    if (!await compruebaUsuario(
        usuarioRegister.getNombre(), usuarioRegister.getContrasena())) {
      usuario = await getUsuario(usuarioRegister.getNombre());
    }
    return usuario;
  }

  Future<Usuario> getUsuario(String nombre) async {
    var user =
        await db.query("usuario", where: "nombre= ?", whereArgs: [nombre]); 
    return Usuario.fromMap(user.first);
  }

  Future<void> modificarImg(Usuario usuario, String rutaImg) async {
    await db.update("usuario", {"imagen": rutaImg},
        where: "nombre= ? ", whereArgs: [usuario.getNombre()]);
  }

  Future<List<Libro>> getLibros() async {
    List<Libro> libros=[];
    var query = await db.query("libro");
    for (var libro in query) {
      libros.add(Libro.fromMap(libro));
    }
    return libros;
  }

  Future<bool> insertarLibro(Libro libro) async {
    bool insertado = false;
    db = await getDB();
    db.insert("libro", libro.toMap());
    var query = await db
        .query("libro", where: "titulo= ?", whereArgs: [libro.getTitulo()]);
    if (query.isNotEmpty) {
      insertado = true;
    }
    return insertado;
  }

  String generarISBN(Libro libro) {
    String isbn = "979";
    String tit = "";
    String aut = "";
    String gen = "";

    for (int i = 0; i < 3; i++) {
      tit += libro.getTitulo()[i];
      aut += libro.getAutor()[i];
      gen += libro.getGenero()[i];
    }
    isbn += tit + aut + gen;
    return isbn;
  }
}

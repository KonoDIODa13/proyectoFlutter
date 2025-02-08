import 'dart:io';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/model/usuario_libro.dart';
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
    createDBUsuarioLibro();
    createDBLibro();
    return db;
  }

  Future<Database> getDB() async {
    return db;
  }

  void setDB(Database database) {
    db = database;
  }

  Future<void> createDBUsuario() async {
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

  Future<void> createDBLibro() async {
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

  Future<void> createDBUsuarioLibro() async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS usuarios_libros (
    usuario_id INTEGER,
    libro_id INTEGER,
    estado TEXT,
    PRIMARY KEY (usuario_id, libro_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (libro_id) REFERENCES libro(id) ON DELETE CASCADE
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

  Future<Usuario?> register(Usuario preUsuario) async {
    Usuario? usuario;
    if (!await compruebaUsuario(
        preUsuario.getNombre(), preUsuario.getContrasena())) {
      await db.insert("usuario", preUsuario.toMap());
      usuario = await getUsuario(preUsuario.getNombre());
    }
    return usuario;
  }

  Future<Usuario> getUsuario(String nombre) async {
    var user =
        await db.query("usuario", where: "nombre= ?", whereArgs: [nombre]);
    Usuario usuario = Usuario.fromMap(user.first);
    return usuario;
  }

  Future<List<UsuarioLibro>> getLibrosByUsuario(int idUsuario) async {
    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT usuario_id, libro_id, estado
    FROM usuarios_libros
    WHERE usuario_id = ?
  ''', [idUsuario]);

    return results.map((map) => UsuarioLibro.fromMap(map)).toList();
  }

  Future<void> modificarImg(Usuario usuario, String rutaImg) async {
    await db.update("usuario", {"imagen": rutaImg},
        where: "nombre= ? ", whereArgs: [usuario.getNombre()]);
  }

  Future<List<Libro>> getLibros() async {
    List<Libro> libros = [];
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

  Future<bool> insertarLibroAUsuario(int idUsuario, int idLibro) async {
    bool insertado = false;
    if (!(await comprobarExiste(idUsuario, idLibro))) {
      UsuarioLibro usuarioLibro = UsuarioLibro(
          usuarioId: idUsuario, libroId: idLibro, estado: "sin empezar");
      await db.insert("usuarios_libros", usuarioLibro.toMap());
      insertado = true;
    }
    return insertado;
  }

  Future<bool> eliminarLibroAUsuario(int idUsuario, int idLibro) async {
    bool eliminado = false;
    if (await comprobarExiste(idUsuario, idLibro)) {
      await db.delete("usuarios_libros",
          where: "usuario_id=? and libro_id=?",
          whereArgs: [idUsuario, idLibro]);
      eliminado = true;
    }
    return eliminado;
  }

  Future<bool> comprobarExiste(idUsuario, idLibro) async {
    bool existe = false;
    var query = await db.query("usuarios_libros",
        where: "usuario_id=? and libro_id=?", whereArgs: [idUsuario, idLibro]);
    if (query.isNotEmpty) {
      existe = true;
    }
    return existe;
  }

  Future<Libro> libroByID(int idLibro) async {
    var query = await db.query("libro", where: "id=?", whereArgs: [idLibro]);
    Libro libro = Libro.fromMap(query.first);
    return libro;
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

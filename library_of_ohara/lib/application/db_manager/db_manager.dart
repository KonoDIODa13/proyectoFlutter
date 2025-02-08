import 'dart:io';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/model/usuario_libro.dart';
import 'package:path/path.dart' as path;

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// esta clase se encarga de toda la comunicación con la base de datos.
class DbManager {
  late Database db;

  /// aqui creamos la direccion en donde se va a quedar la base de datos.
  String getDBPath() {
    final currentDir = Directory.current;
    String dbPath =
        path.join(currentDir.path, "databases", "library_of_ohara.db");
    return dbPath;
  }

  /// aqui se inicializa la bd.
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

  /// esta función crea la tabla de usuario.
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

  /// esta función crea la tabla de libro.
  Future<void> createDBLibro() async {
    /// debido a la falta de tiempo, de momento tanto el autor como genero son
    /// de tipo texto y no una clase como tal.
    /// ademas, la fecha de publicacion es texto aunque trabaje con ella como si fuera
    /// un datetime.
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

  /// esta función crea la tabla de usuarioLibro.
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

  /// esta función se encarga de comprobar si existe un usuario con dicho nombre y contraseña en la bd.
  Future<bool> compruebaUsuario(String nombre, String contra) async {
    bool existe = false;
    var query = await db.query("usuario",
        where: "nombre= ? and contrasena=?", whereArgs: [nombre, contra]);
    if (query.isNotEmpty) {
      existe = true;
    }
    return existe;
  }

  /// esta función realiza el login del usuario. si existe el usuario, lo inicia.
  Future<Usuario?> login(String nombre, String contra) async {
    Usuario? usuario;
    if (await compruebaUsuario(nombre, contra)) {
      usuario = await getUsuario(nombre);
    }
    return usuario;
  }

  /// esta función se encarga de realizar el registro del usuario. si no existe en bd, lo crea.
  Future<Usuario?> register(Usuario preUsuario) async {
    Usuario? usuario;
    if (!await compruebaUsuario(
        preUsuario.getNombre(), preUsuario.getContrasena())) {
      await db.insert("usuario", preUsuario.toMap());
      usuario = await getUsuario(preUsuario.getNombre());
    }
    return usuario;
  }

  /// esta función, obtiene el usuario y lo devuelve.
  Future<Usuario> getUsuario(String nombre) async {
    var user =
        await db.query("usuario", where: "nombre= ?", whereArgs: [nombre]);
    Usuario usuario = Usuario.fromMap(user.first);
    return usuario;
  }

  /// esta función, segun el usuario devuelve los lirbos de dicho usuario.
  Future<List<UsuarioLibro>> getLibrosByUsuario(int idUsuario) async {
    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT usuario_id, libro_id, estado
    FROM usuarios_libros
    WHERE usuario_id = ?
     ''', [idUsuario]);
    return results.map((map) => UsuarioLibro.fromMap(map)).toList();
  }

  ///  esta función, nos devuelve los libros en forma de lista.
  Future<List<Libro>> getLibros() async {
    List<Libro> libros = [];
    var query = await db.query("libro");
    for (var libro in query) {
      libros.add(Libro.fromMap(libro));
    }
    return libros;
  }

  /// esta función sirve para insertar libros a la bd.
  Future<bool> insertarLibro(Libro libro) async {
    bool insertado = false;
    db.insert("libro", libro.toMap());
    var query = await db
        .query("libro", where: "titulo= ?", whereArgs: [libro.getTitulo()]);
    if (query.isNotEmpty) {
      insertado = true;
    }
    return insertado;
  }

  /// esta función se encarga de insertar un campo al usuarios_libros que es donde se guardan los libros de cada usuario.
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

  /// esta función se encarga de eliminar un campo al usuarios_libros que es donde se guardan los libros de cada usuario.
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

  /// esta función se encarga de comprobar si existe dicho libro en la lista de libros del usuario en la bd.
  Future<bool> comprobarExiste(idUsuario, idLibro) async {
    bool existe = false;
    var query = await db.query("usuarios_libros",
        where: "usuario_id=? and libro_id=?", whereArgs: [idUsuario, idLibro]);
    if (query.isNotEmpty) {
      existe = true;
    }
    return existe;
  }

  /// esta función devuelve un libro en funcion del id del libro.
  Future<Libro> libroByID(int idLibro) async {
    var query = await db.query("libro", where: "id=?", whereArgs: [idLibro]);
    Libro libro = Libro.fromMap(query.first);
    return libro;
  }

  /// esta función genera el isbn del libro en cuestion segun su titulo, su autor y se genero.
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

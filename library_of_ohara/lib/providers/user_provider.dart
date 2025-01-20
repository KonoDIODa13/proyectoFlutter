//import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:library_of_ohara/dao/usuario_dao.dart';
import 'package:library_of_ohara/model/libro.dart';
import 'package:library_of_ohara/model/usuario.dart';
import 'package:library_of_ohara/db_creater/db_creater.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class UserProvider extends ChangeNotifier {
  Usuario usuario = Usuario(nombre: "", gmail: "", contrasena: "");
  late Database db;
  late UsuarioDao usuarioDaw;

  UserProvider() {
    usuarioDaw = UsuarioDao();
    inicializarBD();
  }

  void inicializarBD() async {
    DbCreater dbCreater = DbCreater();
    db = await dbCreater.createDB();
    setDB(db);
    await dbCreater.crearDBUsuarios();
    //await dbCreater.crearDBLibros();
    notifyListeners();
  }

  Future<bool> login(String nombre, String contra) async {
    var db = await getDB();
    bool encontrado = false;
    Usuario? user = await usuarioDaw.login(nombre, contra, db);
    if (user != null) {
      encontrado = true;
      setUsuario(user);
    }
    return encontrado;
  }

  Future<bool> register(Usuario usuarioRegistro) async {
    var db = await getDB();
    /*var contrasenaCifrada =
        BCrypt.hashpw(usuarioRegistro.getContrasena(), BCrypt.gensalt());
    usuarioRegistro.setContrasena(contrasenaCifrada);*/
    bool creado = false;
    Usuario? user = await usuarioDaw.register(usuarioRegistro, db);
    if (user != null) {
      setUsuario(user);
      creado = true;
    }
    return creado;
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

  cerrarSesion() {
    var user = Usuario(nombre: "", gmail: "", contrasena: "");
    setUsuario(user);
    notifyListeners();
  }

  Future<List<Libro>> buscarLibros() async {
    List<Libro> libros=[];
    var db = await getDB();

    var query = await db.query("libro");
    for (var queryLibro in query) {
      Libro libro = Libro.fromMap(queryLibro);
      libros.add(libro);
    }
    return libros;
  }
}

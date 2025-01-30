//import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/model/usuario_libro.dart';
import 'package:library_of_ohara/application/services/libro_service.dart';
import 'package:library_of_ohara/application/services/usuario_service.dart';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/db_manager/db_manager.dart';

class AppProvider extends ChangeNotifier {
  late DbManager dbManager;
  late UsuarioService usuarioService;
  late LibroService libroservice;

  AppProvider() {
    dbManager = DbManager();

    usuarioService = UsuarioService(dbManager);

    libroservice = LibroService(dbManager);

    inicializarBD();
  }

  void inicializarBD() async {
    await dbManager.openDB();
    notifyListeners();
  }

  Future<Usuario?> login(String nombre, String contra) async {
    Usuario? usuario;
    var user = await usuarioService.login(nombre, contra);
    if (user != null) {
      usuario = user;
    }
    return usuario;
  }

  Future<Usuario?> register(String nombre, String contra) async {
    /*var contrasenaCifrada =
        BCrypt.hashpw(usuarioRegistro.getContrasena(), BCrypt.gensalt());
    usuarioRegistro.setContrasena(contrasenaCifrada);*/
    Usuario? usuario;
    var user = await usuarioService.register(nombre, contra);
    if (user != null) {
      usuario = user;
    }
    return usuario;
  }

  cerrarSesion() {
    notifyListeners();
  }

  Future<List<Libro>> listaLibros() {
    return libroservice.getLibros();
  }

  Future<List<UsuarioLibro>> getLibrosByUsuario(int id) {
    return usuarioService.getLibrosByUsuario(id);
  }
  /*Future<void> buscarLibros() async {
    var query = await db.query("libro");
    for (var queryLibro in query) {
      Libro libro = Libro.fromMap(queryLibro);
      listaLibros.add(libro);
    }
  }*/
}

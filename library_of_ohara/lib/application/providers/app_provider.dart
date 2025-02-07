//import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/model/usuario_libro.dart';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/db_manager/db_manager.dart';

class AppProvider extends ChangeNotifier {
  late DbManager dbManager;
  late Usuario usuario;
  late List<Libro> libros;
  late List<UsuarioLibro> listaLibrosUsuario;

  AppProvider() {
    dbManager = DbManager();
    inicializarBD();
  }

  void inicializarBD() async {
    await dbManager.openDB();
    libros = await listaLibros();
    notifyListeners();
  }

  Future<Usuario?> login(String nombre, String contra) async {
    var user = await dbManager.login(nombre, contra);
    if (user != null) {
      usuario = user;
      listaLibrosUsuario = await getLibrosByUsuario(usuario.id!);
      rellenarLibrosDeUsuarios();
      return usuario;
    }
    return null;
  }

  Future<Usuario?> register(Usuario preUsuario) async {
    /*var contrasenaCifrada =
        BCrypt.hashpw(usuarioRegistro.getContrasena(), BCrypt.gensalt());
    usuarioRegistro.setContrasena(contrasenaCifrada);*/
    //Usuario? usuario;
    var user = await dbManager.register(preUsuario);
    if (user != null) {
      usuario = user;
      listaLibrosUsuario = await getLibrosByUsuario(usuario.id!);
      rellenarLibrosDeUsuarios();
      return usuario;
    }
    return null;
  }

  Future<void> rellenarLibrosDeUsuarios() async {
    usuario.addlibros(listaLibrosUsuario, libros);
  }

  Future<List<Libro>> listaLibros() async {
    return await dbManager.getLibros();
  }

  Future<List<UsuarioLibro>> getLibrosByUsuario(int id) async {
    return await dbManager.getLibrosByUsuario(id);
  }

  Future<bool> insertarLibroAUsuario(int idUsuario, int idLibro) async {
    bool insertado = false;
    if (await dbManager.insertarLibroAUsuario(idUsuario, idLibro)) {
      listaLibrosUsuario = await getLibrosByUsuario(usuario.id!);
      insertado = true;
    }
    return insertado;
  }

  cerrarSesion() {
    usuario.nombre = "";
    usuario.contrasena = "";
    usuario.gmail = "";
    usuario.imagen = "";
    usuario.id = null;
    usuario.libros.clear();
    notifyListeners();
  }
}

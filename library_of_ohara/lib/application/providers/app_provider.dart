//import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/model/usuario_libro.dart';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/db_manager/db_manager.dart';

class AppProvider extends ChangeNotifier {
  /// clase que se encarga de manejar la base de datos.
  late DbManager dbManager;

  /// instancia del usuario (la empleo asi para facilitarme la vida)
  late Usuario usuario;

  /// lista con los libros de la aplicación (la empleo asi para facilitarme la vida)
  late List<Libro> libros;

  /// lista con los libros del usuario (la empleo asi para facilitarme la vida)
  late List<UsuarioLibro> listaLibrosUsuario;

  /// constructor del proveedor en el cual instancio la clase que maneja la base de datos.
  AppProvider() {
    dbManager = DbManager();
    inicializarBD();
  }

  /// funcioncita que inicializa la base de datos.
  void inicializarBD() async {
    await dbManager.openDB();
    libros = await listaLibros();
    notifyListeners();
  }

  /// función para realizar el login de un usuario.
  /// segun el nombre y la contraseña, buscara un usuario en la base de datos.
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

  /// funcion para realizar el registro de un usuario.
  /// insertará un usuario en la base de datos si no esta.
  Future<Usuario?> register(Usuario preUsuario) async {
    var user = await dbManager.register(preUsuario);
    if (user != null) {
      usuario = user;
      listaLibrosUsuario = await getLibrosByUsuario(usuario.id!);
      rellenarLibrosDeUsuarios();
      return usuario;
    }
    return null;
  }

  /// función para rellenar los libros del usuario segun los libros
  /// que este tenga en base de datos y los libros de la aplicación.
  Future<void> rellenarLibrosDeUsuarios() async {
    usuario.addlibros(listaLibrosUsuario, libros);
  }

  /// función que devuelve la lista de libros de la aplicación.
  Future<List<Libro>> listaLibros() async {
    return await dbManager.getLibros();
  }

  /// función que devuelve la lista de libros segun el usuario.
  Future<List<UsuarioLibro>> getLibrosByUsuario(int id) async {
    return await dbManager.getLibrosByUsuario(id);
  }

  /// función para insertar un libro al usuario.
  Future<bool> insertarLibroAUsuario(int idUsuario, int idLibro) async {
    bool insertado = false;
    if (await dbManager.insertarLibroAUsuario(idUsuario, idLibro)) {
      listaLibrosUsuario = await getLibrosByUsuario(usuario.id!);
      insertado = true;
      recargarLibros(listaLibrosUsuario, libros);
    }
    return insertado;
  }

  /// función para eliminar un libro al usuario.
  Future<bool> eliminarLibroAUsuario(int idUsuario, int idLibro) async {
    bool eliminado = false;
    if (await dbManager.eliminarLibroAUsuario(idUsuario, idLibro)) {
      listaLibrosUsuario = await getLibrosByUsuario(usuario.id!);
      eliminado = true;
      recargarLibros(listaLibrosUsuario, libros);
    }
    return eliminado;
  }

  /// funcion que realiza la recarga de la lista de libros en caso de que
  /// el usuario elimine o añada libros a su lista.
  recargarLibros(
      List<UsuarioLibro> listalibroUsuario, List<Libro> librosTotales) {
    usuario.addlibros(listaLibrosUsuario, librosTotales);
  }

  /// funcioncita que se encarga de eliminar todo dato que tenga el usuario.
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

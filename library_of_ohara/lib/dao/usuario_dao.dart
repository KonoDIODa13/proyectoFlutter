import 'package:library_of_ohara/model/usuario.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class UsuarioDao {
  Future<Usuario?> login(String nombre, String contra, Database db) async {
    Usuario user;
    if (await compruebaUsuario(nombre, contra, db)) {
      user = await getUsuario(nombre, contra, db);
      return user;
    } else {
      return null;
    }
  }

  Future<Usuario?> register(Usuario usuarioRegistro, Database db) async {
    Usuario? user;
    if (await compruebaUsuario(
            usuarioRegistro.getNombre(), usuarioRegistro.getContrasena(), db) ==
        false) {
      await insertarUsuario(usuarioRegistro, db);
      user = await getUsuario(
          usuarioRegistro.getNombre(), usuarioRegistro.getContrasena(), db);
      return user;
    }
    return null;
  }

  Future<bool> compruebaUsuario(
      String nombre, String contra, Database db) async {
    bool encontrado = false;
    var query = await db.query("usuario");
    if (query.isNotEmpty) {
      var user = await db.query("usuario",
          where: "nombre= ? and contrasena= ?", whereArgs: [nombre, contra]);
      if (user.isNotEmpty) {
        encontrado = true;
      }
    }
    return encontrado;
  }
}

Future<Usuario> getUsuario(String nombre, String contra, Database db) async {
  var map = await db.query("usuario",
      where: "nombre= ? and contrasena= ?", whereArgs: [nombre, contra]);
  return Usuario.fromMap(map.first);
}

Future<void> insertarUsuario(Usuario usuarioRegistro, Database db) async {
  db.insert("usuario", usuarioRegistro.toMap());
}

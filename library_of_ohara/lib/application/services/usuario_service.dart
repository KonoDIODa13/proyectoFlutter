import 'package:library_of_ohara/application/db_manager/db_manager.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/model/usuario_libro.dart';

class UsuarioService {
  late DbManager dbManager;

  UsuarioService(DbManager dbM) {
    dbManager = dbM;
  }

  Future<Usuario?> login(String nombre, String contra) async {
    return await dbManager.login(nombre, contra);
  }

  Future<Usuario?> register(String nombre, String contra) async {
    return await dbManager.register(nombre, contra);
  }

  Future<List<UsuarioLibro>> getLibrosByUsuario(int id) async {
    return await dbManager.getLibrosByUsuario(id);
  }
}

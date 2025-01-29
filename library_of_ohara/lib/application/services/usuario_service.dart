import 'package:library_of_ohara/application/db_manager/db_manager.dart';
import 'package:library_of_ohara/application/model/usuario.dart';

class UsuarioService {
  late DbManager dbManager;

  UsuarioService(DbManager dbM) {
    dbManager = dbM;
  }

  Future<Usuario?> login(String nombre, String contra) async {
    Usuario? usuario;
    if (await dbManager.login(nombre, contra) != null) {
      usuario = await dbManager.login(nombre, contra);
    }
    return usuario;
  }

  Future<Usuario?> register(Usuario usuarioRegistro) async {
    Usuario? usuario;

    return usuario;
  }
}

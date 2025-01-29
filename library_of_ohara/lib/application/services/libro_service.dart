import 'package:library_of_ohara/application/db_manager/db_manager.dart';
import 'package:library_of_ohara/application/model/libro.dart';

class LibroService {
  late DbManager dbManager;

  LibroService(DbManager dbM) {
    dbManager = dbM;
  }

  Future<List<Libro>> getLibros() async {
    return await dbManager.getLibros();
  }
}

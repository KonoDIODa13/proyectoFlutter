import 'dart:io';
import 'package:library_of_ohara/model/libro.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbCreater {
  late Database db;

  Future<Database> createDB() async {
    sqfliteFfiInit();
    final currentDir = Directory.current;
    String dbPath =
        path.join(currentDir.path, "databases", "library_of_ohara.db");
    var databaseFactory = databaseFactoryFfi;
    db = await databaseFactory.openDatabase(
      dbPath,
    );
    setDB(db);
    return db;
  }

  void setDB(Database database) {
    db = database;
  }

  Future<Database> getDB() async {
    return db;
  }

  Future<void> crearDBUsuarios() async {
    db = await getDB();
    await db.execute('''
      CREATE TABLE IF NOT EXISTS usuario (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      gmail TEXT,
      contrasena TEXT
  )
  ''');
  }

  Future<void> crearDBLibros() async {
    db = await getDB();
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

    // mistborn I
    /*Libro libro1 = Libro(
        titulo: "El Imperio Final (Mistborn I)",
        autor: "Brandon Sanderson",
        genero: "Fantasia",
        isbn: "1",
        descripcion:
            "Tiene lugar en un equivalente a principios del siglo XVIII, en el distópico mundo de Scadrial, donde cae ceniza constantemente del cielo,"
            " las plantas son color café, y brumas sobrenaturales cubren el paisaje cada noche. Mil años antes del inicio de la novela,"
            " el profetizado Héroe de las Eras ascendió a la divinidad en el Pozo de la ascensión para repeler la Profundidad, un terror que acecha el mundo,"
            " cuya naturaleza real se ha perdido con el tiempo. Aunque la Profundidad fue exitosamente repelida y la humanidad se salvó, el mundo fue cambiado a su forma actual por el Héroe,"
            " quién tomó el título 'Lord Legislador' y ha gobernado sobre el Imperio Final por mil años como un tirano inmortal y dios. Bajo su reinado,"
            " la sociedad fue estratificada en la nobleza, que se cree que fueron los descendientes de los amigos y aliados que le ayudaron a conseguir la divinidad, y los skaa,"
            " el campesinado brutalmente oprimido que desciende de aquellos que se opusieron a él.",
        fechaPublicacion: DateTime.parse("2006-06-17"));
    libro1.setISBN(generarISBN(libro1));
    if (await insertarLibro(libro1)) {
      print("libro ${libro1.getTitulo()} insertado con exito");
    } else {
      print("error al insertar el libro ${libro1.getTitulo()}");
    }*/

    /* mistborn II
    Libro libro5 = Libro(
        titulo: "El Pozo De La Ascensión (Mistborn II)",
        autor: "Brandon Sanderson",
        genero: "Fantasia",
        isbn: "2",
        descripcion: "Durante mil años han caído las cenizas y nada florece. Durante mil años los skaa han sido esclavizados y viven sumidos en un miedo inevitable."
        " Durante mil años el Lord Legislador reina con un poder absoluto gracias al terror, a sus poderes y a su inmortalidad. Pero vencer y matar al Lord Legislador fue la parte sencilla."
        " El verdadero desafío será sobrevivir a las consecuencias de su caída.",
        fechaPublicacion: DateTime.parse("2007-08-21"));
    libro5.setISBN(generarISBN(libro5));
    if (await insertarLibro(libro5)) {
      print("libro ${libro5.getTitulo()} insertado con exito");
    } else {
      print("error al insertar el libro ${libro5.getTitulo()}");
    }*/

    // mistborn III
    /*Libro libro6 = Libro(
        titulo: "El Héroe De Las Eras (Mistborn III)",
        autor: "Brandon Sanderson",
        genero: "Fantasia",
        isbn: "2",
        descripcion:
            "Durante mil años los skaa han vivido esclavizados y sumidos en el miedo al Lord Legislador, que ha reinado con un poder absoluto gracias al terror"
            " y a la poderosa magia de la alomancia. Kelsier, el Superviviente, el único que ha logrado huir de los Pozos de Hathsin, encuentra a Vin, una pobre chica skaa con mucha suerte."
            " Los dos se unen a la rebelión que los skaa intentan desde hace un milenio y vencen al Lord Legislador. Pero acabar con el Lord Legislador es la parte sencilla."
            " El verdadero desafío consistirá en sobrevivir a las consecuencias de su caída. En El Héroe de las Eras se comprende el porqué de la niebla y las cenizas,"
            " las tenebrosas acciones del Lord Legislador y la naturaleza del Pozo de la Ascensión. Vin y el Rey Elend buscan en los últimos escondites de recursos del Lord Legislador"
            " y descubren el peligro que acecha a la humanidad. ¿Conseguirán detenerlo a tiempo?",
        fechaPublicacion: DateTime.parse("2008-10-14"));
    libro6.setISBN(generarISBN(libro6));
    if (await insertarLibro(libro6)) {
      print("libro ${libro6.getTitulo()} insertado con exito");
    } else {
      print("error al insertar el libro ${libro6.getTitulo()}");
    }*/
    // archivo I
    /*Libro libro4 = Libro(
        titulo: "El Camino De Los Reyes (The Stormlight Archive I)",
        autor: "Brandon Sanderson",
        genero: "Fantasia",
        isbn: "1",
        descripcion:
            "La historia va rotando entre los puntos de vista de Kaladin, Shallan Davar, Szeth-hijo-hijo-Vallano, Dalinar Kholin y algunos personajes secundarios,"
            " los cuales parecen llevar vidas aparentemente desvinculadas entre sí. Szeth, un Shin expulsado de su sociedad y condenado a obedecer a sus constantemente cambiantes maestros,"
            " es enviado a asesinar al rey de una de las naciones más poderosas del mundo, Alezkar. Según va avanzando la historia, Szeth va cambiando de maestro,"
            " tratando de esconder que posee una hoja esquirlada, una espada mítica usada por los Caballeros Radiantes y que es capaz de cortar cualquier material."
            " Él también tiene acceso a una serie de poderes que no están disponibles para los humanos normales ('Potenciación'), los cuales fueron poseídos por los Caballeros Radiantes"
            " y se creían perdidos, haciéndole increíblemente difícil derrotarle en batalla.",
        fechaPublicacion: DateTime.parse("2010-07-31"));
    libro4.setISBN(generarISBN(libro4));
    if (await insertarLibro(libro4)) {
      print("libro ${libro4.getTitulo()} insertado con exito");
    } else {
      print("error al insertar el libro ${libro4.getTitulo()}");
    }*/

    // archivo II
    /*Libro libro5 = Libro(
        titulo: "Palabras Radiantes (The Stormlight Archive II)",
        autor: "Brandon Sanderson",
        genero: "Fantasia",
        isbn: "2",
        descripcion:
            "Hace años, Szeth-hijo-hijo-Vallano, el Asesino de Blanco, fue enviado por los parshendi para asesinar al rey alezi Gavilar Kholin (por razones aún no reveladas al lector)."
            " Este asesinato resultó en el Pacto de Venganza entre los altos príncipes de Alezkar y la Guerra del Juicio contra los Parshendi. Ahora Szeth vuelve a estar activo y"
            " es enviado por el rey Taravangian de Kharbranth para matar al alto príncipe Dalinar Kholin (hermano del difunto rey Gavilar).",
        fechaPublicacion: DateTime.parse("2014-03-04"));
    libro5.setISBN(generarISBN(libro5));
    if (await insertarLibro(libro5)) {
      print("libro ${libro5.getTitulo()} insertado con exito");
    } else {
      print("error al insertar el libro ${libro5.getTitulo()}");
    }*/
    // archivo III
    /*Libro libro6 = Libro(
        titulo: "Juramentada (The Stormlight Archive III)",
        autor: "Brandon Sanderson",
        genero: "Fantasia",
        isbn: "2",
        descripcion:
            "La humanidad se enfrenta a una nueva Desolación con el regreso de los Portadores del Vacío, un enemigo tan grande en número como en sed de venganza."
            " La victoria fugaz de los ejercitos alezi de Dalinar Kholin ha tenido consecuencias: el enemigo parshendi ha convocado la violenta tormenta eterna,"
            " que arrasa el mundo y hace que los hasta ahora pacíficos parshmenios descubran con horror que llevan un milenio esclavizados por los humanos. Al mismo tiempo,"
            " en una desesperada huida para alertar a su familia de la amenaza, Kaladin se pregunta si la repentina ira de los parshmenios está justificada.",
        fechaPublicacion: DateTime.parse("2017-11-14"));
    libro6.setISBN(generarISBN(libro6));
    if (await insertarLibro(libro6)) {
      print("libro ${libro6.getTitulo()} insertado con exito");
    } else {
      print("error al insertar el libro ${libro6.getTitulo()}");
    }*/
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

  String generarISBN(Libro libro) {
    String isbn = "9791";
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

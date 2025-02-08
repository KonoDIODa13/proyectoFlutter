import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario_libro.dart';

/// clase que representa al usuario.
class Usuario {
  int? id;
  String nombre;
  String gmail;
  String contrasena;
  String imagen = "";

  /// tiene el campo de lista libros para facilitarme a la hora de
  /// mostrar los libros de un usuario que se verá mas adelante.
  List<Libro> libros;

  /// constructor de la clase Usuario
  Usuario({
    this.id,
    required this.nombre,
    required this.gmail,
    required this.contrasena,
    this.imagen =
        "https://preview.redd.it/h5gnz1ji36o61.png?width=225&format=png&auto=webp&s=84379f8d3bbe593a2e863c438cd03e84c8a474fa",
    List<Libro>? libros,

    /// tuve que hacer este campo y declaralo de esta forma para poder
    /// luego insertar valores en el aunque luego no se vuelque en base de datos.
  }) : libros = libros ?? [];

  /// función para devolver un objeto Usuario de la base de datos.
  factory Usuario.fromMap(Map<String, Object?> map) {
    return Usuario(
        id: map['id'] as int?,
        nombre: map['nombre'] as String,
        gmail: map['gmail'] as String,
        contrasena: map['contrasena'] as String,
        imagen: map['imagen'] as String);
  }
  /// funcion para insertar un usuario en la base de datos.
  Map<String, Object?> toMap() {
    return {
      'nombre': getNombre(),
      'gmail': getGmail(),
      'contrasena': getContrasena(),
      'imagen': getImagen()
    };
  }

  /// las funciones de getes y setes que utilizo a la hora de mostrar la información de Usuario.
  getNombre() {
    return nombre;
  }

  getGmail() {
    return gmail;
  }

  getContrasena() {
    return contrasena;
  }

  getImagen() {
    return imagen;
  }

  setImagen(String imagen) {
    imagen = imagen;
  }

  setNombre(String nombre) {
    nombre = nombre;
  }

  setGmail(String gmail) {
    gmail = gmail;
  }

  setContrasena(String contrasena) {
    contrasena = contrasena;
  }

  getID() {
    return id;
  }
  /// funcioncita para insertar en el campo de lista libros del propio usuario
  /// segun los libros existentes y los libros que el usuario tiene guardados.
  void addlibros(
      List<UsuarioLibro> listaLibrosUsuario, List<Libro> librosTotales) {
    libros.clear();
    /// de esta manera, saco una lista con los ids de libros que tiene el usuario
    Set<int> idsLibrosUsuario = {
      for (var usuarioLibro in listaLibrosUsuario) usuarioLibro.libroId
    };
    for (var libro in librosTotales) {
      if (idsLibrosUsuario.contains(libro.getID())) {
        libros.add(libro);
      }
    }
  }
}

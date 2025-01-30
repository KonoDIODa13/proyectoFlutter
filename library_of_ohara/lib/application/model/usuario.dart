import 'package:library_of_ohara/application/model/libro.dart';

class Usuario {
  String nombre;
  String gmail;
  String contrasena;
  String imagen = "";
  int id = 0;
  List<Libro> libros;
  Usuario(
      {id = 0,
      required this.nombre,
      required this.gmail,
      required this.contrasena,
      this.imagen =
          "https://preview.redd.it/h5gnz1ji36o61.png?width=225&format=png&auto=webp&s=84379f8d3bbe593a2e863c438cd03e84c8a474fa",
      this.libros = const []});
  // Método para convertir un Map en un objeto Usuario
  factory Usuario.fromMap(Map<String, Object?> map) {
    return Usuario(
        id: map['id'] as int,
        nombre: map['nombre'] as String,
        gmail: map['gmail'] as String,
        contrasena: map['contrasena'] as String,
        imagen: map['imagen'] as String);
  }

  Map<String, Object?> toMap() {
    return {
      'nombre': getNombre(),
      'gmail': getGmail(),
      'contrasena': getContrasena(),
      'imagen': getImagen()
    };
  }

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
}

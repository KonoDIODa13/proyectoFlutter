/*
id INTEGER PRIMARY KEY,
      nombre TEXT,
      gmail TEXT,
      contrasena TEXT,
      */

class Usuario {
  String _nombre;
  String _gmail;
  String _contrasena;

  Usuario(
      {required String nombre,
      required String gmail,
      required String contrasena})
      : _contrasena = contrasena,
        _gmail = gmail,
        _nombre = nombre;

  // Método para convertir un Map en un objeto Usuario
  factory Usuario.fromMap(Map<String, Object?> map) {
    return Usuario(
      nombre: map['nombre'] as String,
      gmail: map['gmail'] as String,
      contrasena: map['contrasena'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'nombre': getNombre(),
      'gmail': getGmail(),
      'contrasena': getContrasena(),
    };
  }

  getNombre() {
    return _nombre;
  }

  getGmail() {
    return _gmail;
  }

  getContrasena() {
    return _contrasena;
  }

  setNombre(String nombre) {
    _nombre = nombre;
  }

  setGmail(String gmail) {
    _gmail = gmail;
  }

  setContrasena(String contrasena) {
    _contrasena = contrasena;
  }
}

class Usuario {
  String _nombre;
  String _gmail;
  String _contrasena;
  String _imagen="";

  Usuario(
      {required String nombre,
      required String gmail,
      required String contrasena,
      imagen="https://preview.redd.it/h5gnz1ji36o61.png?width=225&format=png&auto=webp&s=84379f8d3bbe593a2e863c438cd03e84c8a474fa"})
      : _contrasena = contrasena,
        _gmail = gmail,
        _nombre = nombre,
        _imagen= imagen;

  // Método para convertir un Map en un objeto Usuario
  factory Usuario.fromMap(Map<String, Object?> map) {
    return Usuario(
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
    return _nombre;
  }

  getGmail() {
    return _gmail;
  }

  getContrasena() {
    return _contrasena;
  }

  getImagen() {
    return _imagen;
  }

  setImagen(String imagen) {
    _imagen = imagen;
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

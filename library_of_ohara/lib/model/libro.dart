class Libro {
  String _titulo;
  String _autor;
  String _genero;
  String _isbn;
  String _descripcion;
  DateTime _fechaPublicacion;

  Libro({
    required titulo,
    required autor,
    required genero,
    required isbn,
    required descripcion,
    required fechaPublicacion,
  })  : _titulo = titulo,
        _autor = autor,
        _genero = genero,
        _isbn = isbn,
        _descripcion = descripcion,
        _fechaPublicacion = fechaPublicacion;

  factory Libro.fromMap(Map<String, Object?> map) {
    return Libro(
      titulo: map['titulo'] as String,
      autor: map['autor'] as String,
      genero: map['genero'] as String,
      isbn: map['ISBN'] as String,
      descripcion: map['descripcion'] as String,
      fechaPublicacion: DateTime.parse(map['fechaPublicacion'] as String),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'titulo': getTitulo(),
      'autor': getAutor(),
      'genero': getGenero(),
      'ISBN': getISBN(),
      'descripcion': getDescripcion(),
      'fechaPublicacion': getFechaPublicacion().toIso8601String(),
    };
    // toIso8601String() :  convierte la fecha en formato ISO 8601 que es
    // una de las mejores formas para guardar en bd.
  }

  String generarISBN() {
    String isbn = "9791";
    String tit = "";
    String aut = "";
    String gen = "";

    for (int i = 0; i < 3; i++) {
      tit += getTitulo()[i];
      aut += getAutor()[i];
      gen += getGenero()[i];
    }
    isbn += tit + aut + gen;
    return isbn;
  }

  getTitulo() {
    return _titulo;
  }

  getAutor() {
    return _autor;
  }

  getGenero() {
    return _genero;
  }

  getISBN() {
    return _isbn;
  }

  getDescripcion() {
    return _descripcion;
  }

  getFechaPublicacion() {
    return _fechaPublicacion;
  }

  setTitulo(String titulo) {
    _titulo = titulo;
  }

  setAutor(String autor) {
    _autor = autor;
  }

  setGenero(String genero) {
    _genero = genero;
  }

  setISBN(String isbn) {
    _isbn = isbn;
  }

  setDescripcion(String descripcion) {
    _descripcion = descripcion;
  }

  setFechaPublicacion(DateTime fechaPublicacion) {
    _fechaPublicacion = fechaPublicacion;
  }

  getPortada() {
    String portada = "";
    for (var palabra in getTitulo().split("(")[1].split(" ")) {
      portada += palabra;
    }
    portada = portada.replaceFirst(")", "");
    return portada; // sera la ruta
  }
}

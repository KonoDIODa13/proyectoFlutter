class Libro {
  int? id;
  String titulo;
  String autor;
  String genero;
  String isbn;
  String descripcion;
  DateTime fechaPublicacion;

  Libro(
      {this.id,
      required this.titulo,
      required this.autor,
      required this.genero,
      required this.isbn,
      required this.descripcion,
      required this.fechaPublicacion});

  factory Libro.fromMap(Map<String, Object?> map) {
    return Libro(
      id: map['id'] as int?,
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
      //'id': getID(),
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
    String isbn = "979";
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

  getID() {
    return id;
  }

  getTitulo() {
    return titulo;
  }

  getAutor() {
    return autor;
  }

  getGenero() {
    return genero;
  }

  getISBN() {
    return isbn;
  }

  getDescripcion() {
    return descripcion;
  }

  getFechaPublicacion() {
    return fechaPublicacion;
  }

  setTitulo(String titulo) {
    titulo = titulo;
  }

  setAutor(String autor) {
    autor = autor;
  }

  setGenero(String genero) {
    genero = genero;
  }

  setISBN(String isbn) {
    isbn = isbn;
  }

  setDescripcion(String descripcion) {
    descripcion = descripcion;
  }

  setFechaPublicacion(DateTime fechaPublicacion) {
    fechaPublicacion = fechaPublicacion;
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

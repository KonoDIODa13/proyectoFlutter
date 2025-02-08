/// clase que representa un libro.
class Libro {
  int? id;
  String titulo;
  String autor;
  String genero;

  /// el isbn era un campo que queria tener para tener un identificador especial mas alla del propio id.
  String isbn;
  String descripcion;
  DateTime fechaPublicacion;

  /// constructor de la clase libro.
  Libro(
      {this.id,
      required this.titulo,
      required this.autor,
      required this.genero,
      required this.isbn,
      required this.descripcion,
      required this.fechaPublicacion});

  /// realizo esta función para facilitarme el traer el libro de la base de datos.
  factory Libro.fromMap(Map<String, Object?> map) {
    return Libro(
      id: map['id'] as int?,
      titulo: map['titulo'] as String,
      autor: map['autor'] as String,
      genero: map['genero'] as String,
      isbn: map['ISBN'] as String,
      descripcion: map['descripcion'] as String,

      /// debido a que sqlite no tiene fechas, toca parsearlo de String a formato DateTime.
      fechaPublicacion: DateTime.parse(map['fechaPublicacion'] as String),
    );
  }

  /// realizo esta función para insertar un objeto Libro a la base de datos.
  Map<String, Object?> toMap() {
    return {
      'titulo': getTitulo(),
      'autor': getAutor(),
      'genero': getGenero(),
      'ISBN': getISBN(),
      'descripcion': getDescripcion(),
      'fechaPublicacion': getFechaPublicacion().toIso8601String(),
    };

    /// toIso8601String() : convierte la fecha en formato ISO 8601 que es
    /// una de las mejores formas para guardar en bd.
  }
  /// aqui estan todas las funciones basicas de obtencion y modificacion de campos del Libro.
  /// en mi caso, no me gusta utilizar directamente los campos del objeto.
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

  /// esta función la tengo para el tema de la foto/portada del libro a la hora de mostrar el libro.
  /// lo que devolverá sera parte de la ruta a dicha imagen que estará en la carpeta assets.
  getPortada() {
    String portada = "";
    for (var palabra in getTitulo().split("(")[1].split(" ")) {
      portada += palabra;
    }
    portada = portada.replaceFirst(")", "");
    return portada; 
  }
}

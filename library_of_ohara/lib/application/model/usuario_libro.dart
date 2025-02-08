/// esta clase, representa la relaccion entre el usuario y los libros.
class UsuarioLibro {
  int usuarioId;
  int libroId;
  /// a mayores, tengo el campo de estado para mostrar si lo ha empezado, si lo ha terminado, etc.
  String estado;
  /// constructor de la clase UsuarioLibro
  UsuarioLibro({required this.usuarioId, required this.libroId, required this.estado});
  /// función para recibir un objeto de UsuarioLibro de la base de datos.
  factory UsuarioLibro.fromMap(Map<String, dynamic> map) {
    return UsuarioLibro(
      usuarioId: map['usuario_id'],
      libroId: map['libro_id'],
      estado: map['estado'],
    );
  }
  /// función para insertar un nuevo campo de tipo UsuarioLibro en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'usuario_id': usuarioId,
      'libro_id': libroId,
      'estado': estado,
    };
  }

getEstado(){
  return estado;
}
  
}
class UsuarioLibro {
  int usuarioId;
  int libroId;
  String estado;

  UsuarioLibro({required this.usuarioId, required this.libroId, required this.estado});

  factory UsuarioLibro.fromMap(Map<String, dynamic> map) {
    return UsuarioLibro(
      usuarioId: map['usuario_id'],
      libroId: map['libro_id'],
      estado: map['estado'],
    );
  }

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
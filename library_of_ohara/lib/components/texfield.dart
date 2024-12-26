import 'package:flutter/material.dart';

class Texfield extends StatefulWidget {
  final TextEditingController controlador;
  final String etiqueta;
  final String? Function(String?) validacion;
  final bool esOculto;
  final TextInputType tipoTeclado;
  const Texfield(
      {super.key,
      required this.controlador,
      required this.etiqueta,
      required this.validacion,
      this.esOculto = false,
      this.tipoTeclado = TextInputType.text});

  @override
  State<Texfield> createState() => TextfieldState();
}

class TextfieldState extends State<Texfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controlador,
      decoration: InputDecoration(labelText: widget.etiqueta),
      obscureText: widget.esOculto,
      keyboardType: widget.tipoTeclado,
      validator: widget.validacion,
    );
  }
}

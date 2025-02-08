import 'package:flutter/material.dart';
import 'package:library_of_ohara/themes/colors.dart';

/// los campos de texto que utilizo en el formulario.
class Input extends StatefulWidget {
  final TextEditingController controlador;
  final String etiqueta;
  final String? Function(String?) validacion;
  final bool esOculto;
  final TextInputType tipoTeclado;
  const Input(
      {super.key,
      required this.controlador,
      required this.etiqueta,
      required this.validacion,
      this.esOculto = false,
      this.tipoTeclado = TextInputType.text});

  @override
  State<Input> createState() => TextfieldState();
}

class TextfieldState extends State<Input> {
  /// este componente se verá como un textformfield pero ya modificado
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        controller: widget.controlador,
        decoration: InputDecoration(
            label: Text(
          widget.etiqueta,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: titleColor,
          ),
        )),
        style: TextStyle(color: titleColor),
        obscureText: widget.esOculto,
        keyboardType: widget.tipoTeclado,
        validator: widget.validacion,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:library_of_ohara/themes/colors.dart';

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      //width: View.of(context).physicalSize.width / 4,

      child: TextFormField(
        controller: widget.controlador,
        decoration: InputDecoration(
            label: Text(
          widget.etiqueta,
          textAlign: TextAlign.center,
          style: TextStyle(color: titleColor,),
        )),
        style: TextStyle(color: titleColor),
        obscureText: widget.esOculto,
        keyboardType: widget.tipoTeclado,
        validator: widget.validacion,
      ),
      );
  }
}

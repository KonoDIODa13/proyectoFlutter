import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/login.dart';
import 'package:library_of_ohara/application/user_page.dart';
import 'package:library_of_ohara/components/input.dart';
import 'package:library_of_ohara/model/usuario.dart';
import 'package:library_of_ohara/providers/user_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:library_of_ohara/themes/fonts.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final provider = Provider.of<UserProvider>;

  TextEditingController nombreController = TextEditingController();

  TextEditingController gmailController = TextEditingController();

  TextEditingController contrasenaController = TextEditingController();

  String? validatorNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu nombre.';
    }
    return null;
  }

  String? validatorContrasena(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  String? validatorGmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu correo electrónico.';
    }

    if (!RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(value)) {
      return 'Por favor, ingresa un correo electrónico válido.';
    }
    return null;
  }

  crearCuenta(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var usuario = Usuario(
          nombre: nombreController.text,
          gmail: gmailController.text,
          contrasena: contrasenaController.text);

      if (await provider(context, listen: false).register(usuario)) {
        inicioUsuario(context);
      }
    } else {
    }
  }

  inicioUsuario(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UserPage(usuario: provider(context, listen: false).getUser())));
  }

  void volver(BuildContext context) {
    Navigator.pop(context);
  }

  void login(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
            child: Column(
          children: [
            Text(
              "Register",
              style: TextStyle(
                  color: titleColor, fontFamily: titles, fontSize: 45),
            ),
            Container(
                color: backgroundColor2,
                width: View.of(context).physicalSize.width / 2, // curioso
                height: View.of(context).physicalSize.height / 2,
                margin: EdgeInsets.only(
                    top: View.of(context).physicalSize.height / 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Input(
                          controlador: nombreController,
                          etiqueta: "Nombre:",
                          validacion: validatorNombre),
                      Input(
                          controlador: contrasenaController,
                          etiqueta: "Contraseña:",
                          validacion: validatorContrasena,
                          esOculto: true),
                      Input(
                          controlador: gmailController,
                          etiqueta: "Correo Electrónico:",
                          validacion: validatorGmail),
                      ElevatedButton(
                          onPressed: () {
                            crearCuenta(context);
                          },
                          child: Text("Crear Cuenta"))
                    ],
                  ),
                )),
            MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    login(context);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: nonameColor,
                        decoration: TextDecoration.underline,
                        decorationColor: nonameColor),
                  ),
                ))
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            volver(context);
          },
          backgroundColor: backgroundColor2,
          child: Icon(
            Icons.keyboard_double_arrow_left,
            color: titleColor,
          ),
        ));
  }
}

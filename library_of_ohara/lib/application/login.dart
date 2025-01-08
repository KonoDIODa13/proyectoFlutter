import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/register.dart';
import 'package:library_of_ohara/application/user_page.dart';
import 'package:library_of_ohara/components/input.dart';
import 'package:library_of_ohara/providers/user_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:library_of_ohara/themes/fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final provider = Provider.of<UserProvider>;

  TextEditingController nombreController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();
  TextEditingController contrasena2Controller = TextEditingController();

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

  String? validatorContrasena2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    if (contrasenaController.text != contrasena2Controller.text) {
      return 'La contraseñas no coinciden';
    }
    return null;
  }

  login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (await provider(context, listen: false)
          .login(nombreController.text, contrasenaController.text)) {
        inicioUsuario(context);
      }
    } else {}
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

  void register(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
            child: Column(
          children: [
            Text(
              "Login",
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
                        controlador: contrasena2Controller,
                        etiqueta: "Repetir Contraseña:",
                        validacion: validatorContrasena,
                        esOculto: true,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: backgroundColor),
                          onPressed: () {
                            login(context);
                          },
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(color: titleColor),
                          ))
                    ],
                  ),
                )),
            MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    register(context);
                  },
                  child: Text(
                    "Registrarse",
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

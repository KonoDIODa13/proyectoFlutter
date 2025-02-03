import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario_libro.dart';
import 'package:library_of_ohara/application/views/init_app.dart';
import 'package:library_of_ohara/application/views/login.dart';
import 'package:library_of_ohara/application/views/user_page.dart';
import 'package:library_of_ohara/application/components/input.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
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
  final provider = Provider.of<AppProvider>;

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
      return 'Por favor, ingresa tu contraseña.';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres.';
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
      var nombre = nombreController.text;
      var contrasena = contrasenaController.text;
      var gmail = gmailController.text;
      var preUsuario =
          Usuario(nombre: nombre, gmail: gmail, contrasena: contrasena);

      var usuario = await provider(context, listen: false).register(preUsuario);
      if (usuario != null) {
        var listaLibrosByUsuario = await provider(context, listen: false)
            .getLibrosByUsuario(usuario.getID());
        inicioUsuario(context, usuario, listaLibrosByUsuario);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text("error al insertar dicho usuario.")));
      }
    }
  }

  inicioUsuario(BuildContext context, Usuario user, List<UsuarioLibro>listaLibrosByUsuario) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserPage(usuario: user, listaLibrosByUsuario: listaLibrosByUsuario,)));
  }

  void volver(BuildContext context) {
    //Navigator.pop(context); esto no me vale en el mismo momento que le pulsas al enlace de abajo
    Navigator.push(context, MaterialPageRoute(builder: (context) => InitApp()));
  }

  void login(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor2,
          centerTitle: true,
          title: Text(
            "Register",
            style:
                TextStyle(color: titleColor, fontFamily: titles, fontSize: 45),
          ),
        ),
        backgroundColor: backgroundColor,
        body: Center(
            child: Column(
          children: [
            Container(
                color: backgroundColor2,
                width: View.of(context).physicalSize.width / 2, // curioso
                height: View.of(context).physicalSize.height / 1.75,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15.00),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: backgroundColor),
                            onPressed: () {
                              crearCuenta(context);
                            },
                            child: Text(
                              "Crear Cuenta",
                              style: TextStyle(color: titleColor),
                            )),
                      )
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

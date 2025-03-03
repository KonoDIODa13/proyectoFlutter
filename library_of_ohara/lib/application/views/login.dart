import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/views/init_app.dart';
import 'package:library_of_ohara/application/views/register.dart';
import 'package:library_of_ohara/application/views/user_page.dart';
import 'package:library_of_ohara/application/components/input.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
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
  final provider = Provider.of<AppProvider>;

  /// aqui instancio los controladores de los inputs que tengo para iniciar sesión.
  TextEditingController nombreController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();
  TextEditingController contrasena2Controller = TextEditingController();

  /// aqui tengo las funciones para validar los campos de texto.
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

  /// función que si los campos estan validados, realizara la comprobacion de si existe un usuario
  /// con dichos datos en la bd. si existe, iniciará el usuario.
  void login() async {
    if (_formKey.currentState!.validate()) {
      var nombre = nombreController.text;
      var contra = contrasenaController.text;
      var usuario =
          await provider(context, listen: false).login(nombre, contra);
      if (usuario != null) {
        inicioUsuario();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("error al acceder con dicho usuario.")));
      }
    }
  }

  /// función que lleva al usuario a la página principal del usuario
  void inicioUsuario() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserPage()));
  }

  /// función para volver al inicio.
  void volver() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => InitApp()));
  }

  /// función para ir al registro a crear un nuevo usuario.
  void register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  /// aqui renderizo tanto el formulario con los tres inputs como el botón para acceder al usuario.
  /// también, los botones de atras y de registrarse
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double maxheight = 400;
    double containerWidth = screenWidth * 0.5;
    double containerHeight = screenHeight * 0.9;

    if (containerHeight >= maxheight) {
      containerHeight = maxheight;
    }
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor2,
          centerTitle: true,
          title: Text(
            "Login",
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
                width: containerWidth, // curioso
                height: containerHeight,
                margin: EdgeInsets.only(top: screenHeight * 0.1),
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
                        validacion: validatorContrasena2,
                        esOculto: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.00),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: backgroundColor),
                            onPressed: login,
                            child: Text(
                              "Iniciar Sesión",
                              style: TextStyle(color: titleColor),
                            )),
                      )
                    ],
                  ),
                )),
            MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: register,
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
          onPressed: volver,
          backgroundColor: backgroundColor2,
          child: Icon(
            Icons.keyboard_double_arrow_left,
            color: titleColor,
          ),
        ));
  }
}

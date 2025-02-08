import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/views/register.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:library_of_ohara/themes/fonts.dart';
import 'package:library_of_ohara/application/views/login.dart';

class InitApp extends StatefulWidget {
  const InitApp({super.key});

  @override
  State<InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  /// siempre que pueda, me gustar sacar las funciones fuera del renderizado.
  /// en este caso, son dos botones que llevan a dos pantallas,
  /// la de inicio de sesión y la de crear una nueva cuenta.
  void login() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  void register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  /// se que en esta vista, esta como muy vacia. me hubiera gustado
  /// meter algun tipo de descripción de lo que puedes hacer con esta aplicación
  /// pero seguro que el usuario nunca la leeria asi que uWu.
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double containerWidth = screenWidth * 0.4;
    double containerHeight = screenHeight * 0.4;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor2,
        centerTitle: true,
        title: Text("Library Of Ohara",
            style: TextStyle(
                color: titleColor,
                fontSize: 35,
                fontFamily: titles,
                fontStyle: FontStyle.italic)),
      ),
      body: Center(
        child: Container(
          width: containerWidth,
          height: containerHeight,
          margin:
              EdgeInsets.only(top: View.of(context).physicalSize.height / 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor2),
                    onPressed: login,
                    child: Text(
                      "Iniciar Sesión",
                      style: TextStyle(color: titleColor),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor2),
                    onPressed: register,
                    child: Text(
                      "Crear una Cuenta",
                      style: TextStyle(color: titleColor),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

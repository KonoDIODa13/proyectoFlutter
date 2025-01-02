import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/register.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:library_of_ohara/themes/fonts.dart';
import 'package:library_of_ohara/application/login.dart';

class InitApp extends StatefulWidget {
  const InitApp({super.key});

  @override
  State<InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  void login(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  void register(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "LIBRARY OF OHARA",
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: titleColor,
            fontSize: 50,
            fontStyle: FontStyle.italic,
            fontFamily: titles),
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  login(context);
                },
                child: const Text("Iniciar Sesión")),
            ElevatedButton(
                onPressed: () {
                  register(context);
                },
                child: Text("Crear una Cuenta"))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:library_of_ohara/colors.dart';
import 'package:library_of_ohara/fonts.dart';
import 'package:library_of_ohara/login.dart';

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  void login(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
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
                child: const Text("Iniciar Sesión"))
          ],
        ),
      ),
    );
  }
}

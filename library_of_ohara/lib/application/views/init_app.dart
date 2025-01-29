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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double containerWidth= screenWidth*0.4;
    double containerHeight= screenHeight*0.4;
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
                    onPressed: () {
                      login(context);
                    },
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
                    onPressed: () {
                      register(context);
                    },
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

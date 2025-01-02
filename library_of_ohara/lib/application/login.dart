import 'package:flutter/material.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:library_of_ohara/themes/fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void volver(BuildContext context) {
    Navigator.pop(context);
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
              margin: EdgeInsets.only(top: View.of(context).physicalSize.height/8),
              width: View.of(context).physicalSize.width/2, // curioso
              height: View.of(context).physicalSize.height/2,
              child: Column(
                children: [
                  TextFormField()
                ],
              ),
            )
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

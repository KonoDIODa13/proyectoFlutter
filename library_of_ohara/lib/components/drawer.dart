import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/init_app.dart';
import 'package:library_of_ohara/providers/user_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:provider/provider.dart';

class Drawwer extends StatefulWidget {
  const Drawwer({super.key});

  @override
  State<Drawwer> createState() => _DrawwerState();
}

class _DrawwerState extends State<Drawwer> {
  final provider = Provider.of<UserProvider>;

  cerrarSesion(BuildContext context) async {
    await Provider.of<UserProvider>(context).cerrarSesion();
    Navigator.push(context, MaterialPageRoute(builder: (context) => InitApp()));
  }

  modificarUsuario() {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(
        padding: EdgeInsets.only(left: 50),
        children: [
          GestureDetector(
           // onTap: modificarUsuario(),
            child: Row(children: [
              Icon(
                Icons.manage_accounts,
                color: titleColor,
                size: 40,
              ),
              Text(
                "Modificar Usuario",
                style: TextStyle(color: titleColor),
              )
            ]),
          ),
          GestureDetector(
           // onLongPress: cerrarSesion(context),
             child: Row(children: [
              Icon(
                Icons.logout,
                color: titleColor,
                size: 40,
              ),
              Text(
                "Cerrar Sesión",
                style: TextStyle(color: titleColor),
              )
            ]),
          )
          /*ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
              onPressed: () {
                cerrarSesion(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: titleColor,
                    size: 40,
                  ),
                  Text("Cerrar Sesión", style: TextStyle(color: titleColor))
                ],
              ))*/
        ],
      ),
    );
  }
}

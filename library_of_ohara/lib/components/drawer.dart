import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/init_app.dart';
import 'package:library_of_ohara/providers/user_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:provider/provider.dart';

class Drawwer extends StatefulWidget{
  const Drawwer({super.key});

  @override
  State<Drawwer> createState() => _DrawwerState();
}

class _DrawwerState extends State<Drawwer> {

final provider = Provider.of<UserProvider>;
 void cerrarSesion(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).cerrarSesion();
    Navigator.push(context, MaterialPageRoute(builder: (context) => InitApp()));
  }

  @override
  Widget build(BuildContext context) {
   return Drawer(
        backgroundColor: backgroundColor,
        
        child: Column(
          children: [
            Text("primer contenido", style: TextStyle(color: titleColor)),
            Text("segundo contenido", style: TextStyle(color: titleColor)),
            Text("tercero contenido", style: TextStyle(color: titleColor)),
            ElevatedButton(
                onPressed: () {
                  cerrarSesion(context);
                },
                child: Text("Cerrar Sesión"))
          ],
        ),
      );
  }
}
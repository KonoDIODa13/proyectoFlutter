import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/views/init_app.dart';
import 'package:library_of_ohara/application/components/input.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:provider/provider.dart';

class Drawwer extends StatefulWidget {
  const Drawwer({super.key});

  @override
  State<Drawwer> createState() => _DrawwerState();
}

class _DrawwerState extends State<Drawwer> {
  final provider = Provider.of<AppProvider>;

  cerrarSesion(BuildContext context) async {
    provider(context,listen: false).cerrarSesion();
    Navigator.push(context, MaterialPageRoute(builder: (context) => InitApp()));
  }

  cambiarImagen() {
    var controlador = TextEditingController();
    var etiqueta = "Cambiar imagen:";
    String? validar(String? value) {
      if (value == null || value.isEmpty) {
        return 'Por favor, ingresa la url de la imagen.';
      }
      return null;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Container(
            child: Form(
                child: Column(children: [
          Input(
              controlador: controlador,
              etiqueta: etiqueta,
              validacion: validar),
          ElevatedButton(onPressed: () {}, child: Text("modificar"))
        ])));
      },
    );
  }

  modificarUsuario() {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: backgroundColor,
        child: ListView(
          children: [
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.manage_accounts_rounded,
                    color: titleColor,
                  ),
                  Text(
                    "Modificar Usuario",
                    style: TextStyle(color: titleColor),
                  )
                ],
              ),
              onTap: () {
                modificarUsuario();
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.image_outlined, color: titleColor),
                  Text(
                    "Cambiar Foto",
                    style: TextStyle(color: titleColor),
                  )
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.no_accounts_rounded,
                    color: titleColor,
                  ),
                  Text("Cerrar Sesión", style: TextStyle(color: titleColor))
                ],
              ),
              onTap: () {
                cerrarSesion(context);
              },
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/views/init_app.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:provider/provider.dart';

///  este es el componente del drawer que se desplegará si le pulsamos en la foto.
class Drawwer extends StatefulWidget {
  const Drawwer({super.key});

  @override
  State<Drawwer> createState() => _DrawwerState();
}

class _DrawwerState extends State<Drawwer> {
  final provider = Provider.of<AppProvider>;

  // aqui tengo alguna de la funcionalidad que no me ha dado tiempo a implementar xD
  void cerrarSesion() {
    provider(context, listen: false).cerrarSesion();
    Navigator.push(context, MaterialPageRoute(builder: (context) => InitApp()));
  }

  void modificarDatosUsuario() {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text("Funcionalidad no implementada.")));
  }

  void cambiarImagen() {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text("Funcionalidad no implementada.")));
  }

  /// aquí veremos los elementos del drawer que serán pulsables.
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
                onTap: modificarDatosUsuario),
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
                onTap: cambiarImagen),
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
                onTap: cerrarSesion)
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:provider/provider.dart';

class BookWindow extends StatelessWidget {
  final Usuario usuario;
  final Libro libro;
  const BookWindow({super.key, required this.usuario, required this.libro});

  @override
  Widget build(BuildContext context) {
    String portada = "assets/images/${libro.getPortada()}.jpg";
    return Scaffold(
      body: Card(
        child: Row(
          children: [
            Column(
              children: [
                Text("Titulo: ${libro.getTitulo()}"),
                Text("Autor: ${libro.getAutor()}"),
                Chip(label: Text("${libro.getGenero()}")),
                Text("Titulo: ${libro.getDescripcion()}"),
                Text("Titulo: ${libro.getFechaPublicacion()}"),
                ElevatedButton(
                    onPressed: () async {
                      if (await Provider.of<AppProvider>(context, listen: false)
                          .insertarLibroAUsuario(
                              usuario.getID(), libro.getID())) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text("Añadido a la lista con exito.")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                                "No se puede añadir a la lista.")));
                      }
                    },
                    child: Text("Añadir a la Lista."))
              ],
            ),
            Spacer(),
            Expanded(child: Image.asset(portada))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: backgroundColor2,
        child: Icon(
          Icons.keyboard_double_arrow_left,
          color: titleColor,
        ),
      ),
    );
  }
}

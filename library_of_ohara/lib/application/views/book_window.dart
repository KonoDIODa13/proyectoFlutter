import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
import 'package:library_of_ohara/application/views/user_page.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:library_of_ohara/themes/fonts.dart';
import 'package:provider/provider.dart';

/// ventana en la que vemos las características de los libros a su vez de
class BookWindow extends StatelessWidget {
  final Libro libro;
  BookWindow({super.key, required this.libro});
  late Usuario usuario;
  final provider = Provider.of<AppProvider>;
  late bool yaEnLista = false;

  /// en la vista, tendremos tanto la imagen, como el titulo, la descripcion, etc del libro
  /// así como el botón que en función de que este en la lista, nos permitirá añadirlo a la lista o no.
  Widget build(BuildContext context) {
    usuario = provider(context, listen: false).usuario;
    for (var libroDelUsuario in usuario.libros) {
      if (libroDelUsuario.getID() == libro.getID()) {
        yaEnLista = true;
      }
    }
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = 15;
    double espacioEntre = screenHeight * 0.05;
    if (screenWidth > 600) {
      fontSize = 17;
    }
    if (screenWidth > 900) {
      fontSize = 20;
    }

    double imgWidth = screenWidth * 0.4;
    String portada = "assets/images/${libro.getPortada()}.jpg";
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor2,
          automaticallyImplyLeading: false,
          title: Text(
            "${libro.getTitulo()}",
            style: TextStyle(
              color: titleColor,
              fontSize: 30,
              fontFamily: titles,
            ),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: screenHeight,
          child: Card(
            color: backgroundCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(portada,
                        width: imgWidth,
                        height: screenHeight,
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: espacioEntre),
                      Text(
                        "Autor: ${libro.getAutor()}",
                        style: TextStyle(fontSize: fontSize, color: titleColor),
                      ),
                      SizedBox(height: espacioEntre),
                      Text(
                        "Género: ${libro.getGenero()}",
                        style: TextStyle(fontSize: fontSize, color: titleColor),
                      ),
                      SizedBox(height: espacioEntre),
                      Text(
                        "Descripción: ${libro.getDescripcion()}",
                        style: TextStyle(fontSize: fontSize, color: titleColor),
                      ),
                      SizedBox(height: espacioEntre),
                      Text(
                        "Fecha de Publicación: ${libro.fechaPublicacion}",
                        style: TextStyle(fontSize: fontSize, color: titleColor),
                      ),
                      SizedBox(height: espacioEntre),
                      yaEnLista
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: backgroundColor2),
                              onPressed: () async {
                                if (await Provider.of<AppProvider>(context,
                                        listen: false)
                                    .eliminarLibroAUsuario(
                                        usuario.getID(), libro.getID())) {
                                  provider(context, listen: false)
                                      .listaLibrosUsuario;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: const Text(
                                              "Libro eliminado de la lista con exito.")));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: const Text(
                                              "No se puede añadir a la lista.")));
                                }
                              },
                              child: Text(
                                "Eliminar de la lista",
                                style: TextStyle(color: titleColor),
                              ))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: backgroundColor2),
                              onPressed: () async {
                                if (await Provider.of<AppProvider>(context,
                                        listen: false)
                                    .insertarLibroAUsuario(
                                        usuario.getID(), libro.getID())) {
                                  provider(context, listen: false)
                                      .listaLibrosUsuario;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: const Text(
                                              "Añadido a la lista con exito.")));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: const Text(
                                              "No se puede añadir a la lista.")));
                                }
                              },
                              child: Text(
                                "Añadir a la lista",
                                style: TextStyle(color: titleColor),
                              ))
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),

        /// el botón este para ir para atrás, nos devolverá a la página de usuario.
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserPage()));
          },
          backgroundColor: backgroundColor2,
          child: Icon(
            Icons.keyboard_double_arrow_left,
            color: titleColor,
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:library_of_ohara/themes/fonts.dart';
import 'package:provider/provider.dart';

class BookWindow extends StatelessWidget {
  final Usuario usuario;
  final Libro libro;
  const BookWindow({super.key, required this.usuario, required this.libro});

  @override
  Widget build(BuildContext context) {
    //final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;
    String portada = "assets/images/${libro.getPortada()}.jpg";
    return Scaffold(
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
        body: Card(
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
                  child: Image.asset(
                    portada,
                    width: 80,
                    height: 120,
                    fit: BoxFit.cover
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Text(
                    libro.getAutor(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),*/
                  SizedBox(height: 5),
                  Text(
                    "Autor: ${libro.getAutor()}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Género: ${libro.getGenero()}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],))
              ],
            ),
          ),
        )

        /*body: Container(
        width: 1000,
        height: 1000,
        color: backgroundCardColor,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: 350,
              height: 500,
              child: Image.asset(portada),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Autor: ${libro.getAutor()}",
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (await Provider.of<AppProvider>(context, listen: false)
                          .insertarLibroAUsuario(
                              usuario.getID(), libro.getID())) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                const Text("Añadido a la lista con exito.")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                const Text("No se puede añadir a la lista.")));
                      }
                    },
                    child: Text("Añadir a la Lista."))
              ],
            ),
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
      ),*/
        );
  }
}

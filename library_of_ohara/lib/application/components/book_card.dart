import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
import 'package:library_of_ohara/application/views/book_window.dart';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final Libro libro;
  BookCard({super.key, required this.libro});
  final provider = Provider.of<AppProvider>;
  late Usuario usuario;

  @override
  Widget build(BuildContext context) {
    usuario = provider(context, listen: false).usuario;
    final double screenWidth = MediaQuery.of(context).size.width;
    String portada = "assets/images/${libro.getPortada()}.jpg";
    double fontSize = 15;
    if (screenWidth > 600) {
      fontSize = 17;
    }
    if (screenWidth > 900) {
      fontSize = 20;
    }
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookWindow(libro: libro)));
        },
        child: Card(
          color: backgroundCardColor,
          child: Column(
            children: [
              Container(
                width: screenWidth,
                color: backgroundColor2,
                child: Text(libro.getTitulo(),
                    style: TextStyle(
                      color: titleColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                  child: Image.asset(
                portada,
                fit: BoxFit.cover,
              )),
            ],
          ),
        ));
  }
}

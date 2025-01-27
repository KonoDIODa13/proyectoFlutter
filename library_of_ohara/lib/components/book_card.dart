import 'package:flutter/material.dart';
import 'package:library_of_ohara/model/libro.dart';
import 'package:library_of_ohara/themes/colors.dart';

class BookCard extends StatelessWidget {
  Libro libro;
  BookCard({super.key, required this.libro});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    String portada = "assets/images/${libro.getPortada()}.jpg";
    double fontSize = 13;
    if (screenWidth > 600) {
      fontSize = 15;
    }
    if (screenWidth > 900) {
      fontSize = 17;
    }
    return Card(
      color: backgroundCardColor,
      child: Column(
        children: [
          Text(libro.getTitulo(),
              style: TextStyle(
                color: titleColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center),
          Expanded(
              child: Image.asset(
            portada,
            fit: BoxFit.cover,
          )),
          Text("Autor: ${libro.getAutor()}")
        ],
      ),
    );
  }
}

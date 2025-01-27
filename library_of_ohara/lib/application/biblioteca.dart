import 'package:flutter/material.dart';
import 'package:library_of_ohara/components/book_card.dart';
import 'package:library_of_ohara/model/libro.dart';
import 'package:library_of_ohara/model/usuario.dart';
import 'package:library_of_ohara/providers/user_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:provider/provider.dart';

class Biblioteca extends StatefulWidget {
  final provider = Provider.of<UserProvider>;
  final Usuario usuario;

  const Biblioteca({super.key, required this.usuario});

  @override
  State<Biblioteca> createState() => _BibliotecaState();
}

class _BibliotecaState extends State<Biblioteca> {
  final provider = Provider.of<UserProvider>;
  List<Libro> libros = [];

  @override
  Widget build(BuildContext context) {
    libros = provider(context).listaLibros;
    final double screenWidth = MediaQuery.of(context).size.width;
    // Calcular dinámicamente el número de columnas
    int crossAxisCount = 2; // Valor por defecto
    //double fontSize = 13;
    if (screenWidth > 600) {
      crossAxisCount = 3; // Pantallas medianas (tablets)
      //fontSize = 15;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4;
      //fontSize = 17;

      // Pantallas grandes
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: GridView.builder(
        itemCount: libros.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, // Número de columnas
          crossAxisSpacing: 10, // Espaciado horizontal entre celdas
          mainAxisSpacing: 10,
        ), // Espaciado vertical entre celdas,)
        itemBuilder: (context, index) {
          return BookCard(libro: libros[index]);
        },
      ),
    );
  }
}

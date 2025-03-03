import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/components/book_card.dart';
import 'package:library_of_ohara/application/model/libro.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:provider/provider.dart';

/// vista para listar los libros de la aplicación.
class Biblioteca extends StatelessWidget {
  final provider = Provider.of<AppProvider>;

  late List<Libro> libros;

  Biblioteca({super.key});

  /// en la vista, realizo un gridview para mostrar cada libro en una carta.
  @override
  Widget build(BuildContext context) {
    libros = provider(context).libros;
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    /// segun el tamaño de la pantalla, los elementos se veran de distinta manera.
    if (screenWidth > 600) {
      crossAxisCount = 3;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: GridView.builder(
        itemCount: libros.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return BookCard(libro: libros[index]);
        },
      ),
    );
  }
}

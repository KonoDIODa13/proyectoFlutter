import 'package:flutter/material.dart';
import 'package:library_of_ohara/model/libro.dart';
import 'package:library_of_ohara/model/usuario.dart';
import 'package:library_of_ohara/providers/user_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:provider/provider.dart';

class Biblioteca extends StatefulWidget {
  final provider = Provider.of<UserProvider>;
  Usuario usuario;

  Biblioteca({super.key, required this.usuario});

  @override
  State<Biblioteca> createState() => _BibliotecaState();
}

class _BibliotecaState extends State<Biblioteca> {
  final provider = Provider.of<UserProvider>;
  List<Libro> libros = [];

  @override
  Widget build(BuildContext context) {
    libros = provider(context).listaLibros;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: ListView.builder(
          itemCount: libros.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(libros[index].getTitulo()),
                Text(libros[index].getAutor()),
                Text(libros[index].getGenero()),
              ],
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/components/book_card.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/model/usuario_libro.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:provider/provider.dart';

class BodyUsuario extends StatefulWidget {
  BodyUsuario({super.key});

  @override
  State<BodyUsuario> createState() => _BodyUsuarioState();
}

class _BodyUsuarioState extends State<BodyUsuario> {
  final provider = Provider.of<AppProvider>;

  late Usuario usuario;

  late List<UsuarioLibro> listaLibrosUsuario;

  @override
  Widget build(BuildContext context) {
    listaLibrosUsuario = provider(context).listaLibrosUsuario;
    usuario = provider(context).usuario;
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;

    if (screenWidth > 600) {
      crossAxisCount = 3;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4;
    }
    return Column(
      children: [
        Center(
          child: Text("Tus Libros", style: TextStyle(color: titleColor, fontSize: 20),),
        ),
        listaLibrosUsuario.isEmpty
            ? Center(child: Text("Aun no tienes libros en la bd"))
            : Expanded(
                child: GridView.builder(
                itemCount: usuario.libros.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount),
                itemBuilder: (context, index) {
                  return BookCard(libro: usuario.libros[index]);
                },
              ))
      ],
    );
  }
}

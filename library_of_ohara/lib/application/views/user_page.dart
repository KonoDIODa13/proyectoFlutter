import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/components/body_usuario.dart';
import 'package:library_of_ohara/application/model/usuario_libro.dart';
import 'package:library_of_ohara/application/views/biblioteca.dart';
import 'package:library_of_ohara/application/components/drawer.dart';
import 'package:library_of_ohara/application/model/usuario.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:library_of_ohara/themes/fonts.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final provider = Provider.of<AppProvider>;
  late Usuario usuario;
  late List<UsuarioLibro> listaLibrosUsuario;
  int indice = 1;
  Widget? body;

  changeWindow(int index) async {
    setState(() {
      switch (index) {
        case 0:
          indice = index;
          body = Biblioteca();
          break;
        case 1:
          indice = index;
          body = BodyUsuario();
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    usuario = provider(context, listen: false).usuario;
    listaLibrosUsuario = provider(context).listaLibrosUsuario;
    body= BodyUsuario();
    return Scaffold(
      drawer: Drawwer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor2,
        title: Text(
          usuario.getNombre(),
          style: TextStyle(color: titleColor, fontSize: 40, fontFamily: titles),
        ),
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage(usuario.getImagen.toString().isEmpty
                  ? "https://preview.redd.it/h5gnz1ji36o61.png?width=225&format=png&auto=webp&s=84379f8d3bbe593a2e863c438cd03e84c8a474fa"
                  : usuario.getImagen()),
            ),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
                color: titleColor,
              ),
              backgroundColor: backgroundColor,
              label: "Biblioteca"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: titleColor,
              ),
              backgroundColor: backgroundColor,
              label: "Inicio"),
        ],
        backgroundColor: backgroundColor2,
        currentIndex: indice,
        fixedColor: titleColor,
        unselectedItemColor: titleColor,
        onTap: changeWindow,
      ),
      body: body,
    );
  }
}

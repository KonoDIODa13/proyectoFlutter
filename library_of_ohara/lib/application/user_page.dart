import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/biblioteca.dart';
import 'package:library_of_ohara/components/drawer.dart';
import 'package:library_of_ohara/model/usuario.dart';
import 'package:library_of_ohara/providers/user_provider.dart';
import 'package:library_of_ohara/themes/colors.dart';
import 'package:library_of_ohara/themes/fonts.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  final Usuario usuario;

  const UserPage({super.key, required this.usuario});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final provider = Provider.of<UserProvider>;
  int indice = 1;
  Widget body = Center(child: Text("aun en desarrollo"));
  changeWindow(int index) {
    switch (index) {
      case 0:
        setState(() {
          indice = index;
          body = Biblioteca(usuario: widget.usuario);
        });
        break;
      case 1:
        setState(() {
          indice = index;
          body = Center(child: Text(widget.usuario.getNombre()));
        });
        break;
      case 2:
        setState(() {
          indice = index;
          body = Center(child: Text("Aun en desarrollo"));
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawwer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor2,
        title: Text(
          widget.usuario.getNombre(),
          style: TextStyle(color: titleColor, fontSize: 40, fontFamily: titles),
        ),
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.usuario.getImagen
                      .toString()
                      .isEmpty
                  ? "https://preview.redd.it/h5gnz1ji36o61.png?width=225&format=png&auto=webp&s=84379f8d3bbe593a2e863c438cd03e84c8a474fa"
                  : widget.usuario.getImagen()),
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
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmarks,
                color: titleColor,
              ),
              backgroundColor: backgroundColor,
              label: "Tus libros"),
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

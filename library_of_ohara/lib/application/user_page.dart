import 'package:flutter/material.dart';
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
//Usuario usuario= widget.usuario;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                Text("primer contenido"),
                Text("segundo contenido"),
                Text("tercero contenido"),
              ],
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: backgroundColor,
            title: Text(
              widget.usuario.getNombre(),
              style: TextStyle(
                  color: titleColor, fontSize: 40, fontFamily: titles),
            ),
            leading: Builder(builder: (context) {
              return GestureDetector(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/default_user.jpg"),
                  child: Text("Tú", textAlign: TextAlign.center),
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
            backgroundColor: backgroundColor,
            currentIndex: 1,
            fixedColor: titleColor,
            unselectedItemColor: titleColor,
          ),
          body: Center(child: Text(widget.usuario.getNombre())),
        ));
  }
}

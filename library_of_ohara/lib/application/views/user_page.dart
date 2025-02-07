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
  Widget? body= BodyUsuario();

  changeWindow(int index) async {
    switch (index) {
      case 0:
        setState(() {
          indice = index;
          body = Biblioteca();
        });
        break;
      case 1:
        setState(() {
          indice = index;
          body = BodyUsuario();
        });
        break;
         case 2:
        setState(() {
          indice = index;
          body = Center(child: Text("en desarrollo"),);
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    usuario = provider(context, listen: false).usuario;
    listaLibrosUsuario = provider(context).listaLibrosUsuario;
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
              /*backgroundImage: NetworkImage(usuario.getImagen.toString().isEmpty
                  ? "https://st3.depositphotos.com/3538469/16455/v/450/depositphotos_164553890-stock-illustration-vector-user-icon.jpg"
                  : usuario.getImagen()),*/
                  backgroundImage: NetworkImage("https://st3.depositphotos.com/3538469/16455/v/450/depositphotos_164553890-stock-illustration-vector-user-icon.jpg"),
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
                Icons.my_library_books,
                color: titleColor,
              ),
              backgroundColor: backgroundColor,
              label: "Tus Libros"),
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

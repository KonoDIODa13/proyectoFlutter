import 'package:flutter/material.dart';
import 'package:library_of_ohara/model/usuario.dart';
import 'package:library_of_ohara/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    return Scaffold(
      body: Center(child: Text(widget.usuario.getNombre())),
    );
  }
}

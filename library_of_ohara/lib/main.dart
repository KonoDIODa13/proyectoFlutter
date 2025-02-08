import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/views/init_app.dart';
import 'package:library_of_ohara/application/providers/app_provider.dart';
import 'package:provider/provider.dart';

/// inicio de la aplicación.
void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppProvider(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
/// para poder iniciarla, requiero inicializar primero el poveedor 
/// para toda la gestión de datos.
  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitApp(),
    );
  }
}

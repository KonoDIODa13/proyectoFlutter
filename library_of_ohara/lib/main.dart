import 'package:flutter/material.dart';
import 'package:library_of_ohara/application/init_app.dart';
import 'package:library_of_ohara/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitApp(),
    );
  }
}

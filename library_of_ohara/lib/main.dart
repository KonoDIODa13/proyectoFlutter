import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 111, 43, 97),
        appBar: AppBar(
          title: Text(
            "LYBRARY OF OHARA",
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Color.fromARGB(255, 219, 175, 0),
              fontSize: 50,
              fontStyle: FontStyle.italic,
              fontFamily: "SedgwickAveDisplay"
              ),
          backgroundColor: Color.fromARGB(255, 111, 43, 97),
        ),
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

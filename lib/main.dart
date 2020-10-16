import 'package:flutter/material.dart';
import 'package:pract_dos/home/home_page.dart';

void main() {
  // TODO: inicializar hive y agregar el adapter
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 2',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

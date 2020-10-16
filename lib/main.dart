import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pract_dos/home/home_page.dart';

import 'models/todo_reminder.dart';

void main() async {
  // TODO: inicializar hive y agregar el adapter

  var box = await Hive.openBox('testBox');
  // box.put('name', 'David');
  Hive.registerAdapter(ReminderAdapter());

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

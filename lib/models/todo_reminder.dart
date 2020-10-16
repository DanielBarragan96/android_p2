// TODO: convertir en adapter de Hive y utilizar build runner para generar el adapter

import 'package:hive/hive.dart';

part 'todo_reminder.g.dart';

//To generate product.g.dart use command:
//flutter packages pub run build_runner build
@HiveType(typeId: 1, adapterName: "ReminderAdapter")
class TodoRemainder {
  @HiveType(typeId: 0)
  final String todoDescription;
  @HiveType(typeId: 1)
  final String hour;

  TodoRemainder({
    this.todoDescription,
    this.hour,
  });
}

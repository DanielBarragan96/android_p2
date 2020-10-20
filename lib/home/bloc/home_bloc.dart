import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pract_dos/models/todo_reminder.dart';

import '../../models/todo_reminder.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // TODO: inicializar la box
  Box _reminderBox = Hive.box("reminderBox");

  HomeBloc() : super(HomeInitialState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is OnLoadRemindersEvent) {
      try {
        List<TodoRemainder> _existingReminders = _loadReminders();
        yield LoadedRemindersState(todosList: _existingReminders);
      } on DatabaseDoesNotExist catch (_) {
        yield NoRemindersState();
      } on EmptyDatabase catch (_) {
        yield NoRemindersState();
      }
    }
    if (event is OnAddElementEvent) {
      _saveTodoReminder(event.todoReminder);
      yield NewReminderState(todo: event.todoReminder);
    }
    if (event is OnReminderAddedEvent) {
      yield AwaitingEventsState();
    }
    if (event is OnRemoveElementEvent) {
      _removeTodoReminder(event.removedAtIndex);
    }
  }

  List<TodoRemainder> _loadReminders() {
    List<TodoRemainder> _remindersList = [];
    if (_reminderBox.isNotEmpty) {
      for (int index = 0; index < _reminderBox.length; index++) {
        _remindersList.add(_reminderBox.getAt(index));
      }
      return _remindersList;
    }
    throw EmptyDatabase();
  }

  void _saveTodoReminder(TodoRemainder todoReminder) {
    if (todoReminder != null) _reminderBox.add(todoReminder);
  }

  void _removeTodoReminder(int removedAtIndex) {
    if (_reminderBox.length > removedAtIndex)
      _reminderBox.deleteAt(removedAtIndex);
  }
}

class DatabaseDoesNotExist implements Exception {}

class EmptyDatabase implements Exception {}

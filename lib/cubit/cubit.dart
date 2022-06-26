import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../tabs/archived_tasks.dart';
import '../tabs/done_tasks.dart';
import '../tabs/new_tasks.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool isShown = false;
  IconData icon = Icons.edit;
  int currentIndex = 0;

  changeBottomSheet(bool toggleShown, IconData favIcon) {
    isShown = toggleShown;
    icon = favIcon;
    emit(ChangeBottomSheetState(toggleShown, favIcon));
  }

  final List<Widget> screens = const [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];

  final List<String> titles = const [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeTab(int index) {
    currentIndex = index;
    emit(AppBottomNavBarState(index));
  }

  getDataFromDatabase(Database db) {
    newTasks.clear();
    doneTasks.clear();
    archivedTasks.clear();

    emit(AppGetDatabaseLoadingState());
    db.rawQuery('SELECT * FROM tasks').then((value) {
      for (var element in value) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else if (element['status'] == 'archived') {
          archivedTasks.add(element);
        }
      }
      emit(AppGetDataFromDatabaseState());
      //log(value.toString());
    });
  }

  updateData(String status, int id) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState(status, id));
    });
  }

  deleteData(int id) async {
    database.rawDelete(
      'Delete FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState(id));
    });
  }

  createDatabase() {
    openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (Database db, int version) {
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) => log('Table created'))
            .catchError(
                (error) => log('Error when create table: ${error.toString()}'));
        log('Database opened');
      },
      onOpen: (Database db) {
        log('Database opened');
        getDataFromDatabase(db);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState(value));
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    // await database.insert('tasks', {'name': name, 'done': 0});
    await database.transaction(
      (txn) => txn.rawInsert(
        'INSERT INTO tasks (title, date, time, status) VALUES (?, ?, ?, ?)',
        [title, date, time, 'new'],
      ).then((value) {
        log('$value Inserted Successfully');
        emit(AppInsertToDatabaseState(title, date, time));

        getDataFromDatabase(database);
      }),
    );
  }
}

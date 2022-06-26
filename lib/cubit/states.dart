import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeBottomSheetState extends AppStates {
  final bool isShown;
  final IconData icon;

  ChangeBottomSheetState(this.isShown, this.icon);
}

class AppBottomNavBarState extends AppStates {
  final int currentIndex;

  AppBottomNavBarState(this.currentIndex);
}

class AppCreateDatabaseState extends AppStates {
  final Database database;

  AppCreateDatabaseState(this.database);
}

class AppInsertToDatabaseState extends AppStates {
  final String title;
  final String date;
  final String time;

  AppInsertToDatabaseState(this.title, this.date, this.time);
}

class AppGetDataFromDatabaseState extends AppStates {}

class AppUpdateDatabaseState extends AppStates {
  final String status;
  final int id;

  AppUpdateDatabaseState(this.status, this.id);
}

class AppDeleteDatabaseState extends AppStates {
  final int id;

  AppDeleteDatabaseState(this.id);
}

class AppGetDatabaseLoadingState extends AppStates {}

import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:developer';
import 'package:radons_workout_app/essentials/weeklyRoutine.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //acts as a singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  String databaseName = 'weeklyRoutines.db';

  Future<Database> get database async {
    if (_database != null) {
      log('DataBaseHelper - database(): DB not null, returning');
      return _database!;
    }

    log('DataBaseHelper - database(): Initiating DB since it is null');

    //workouts.db is where the info will be stored
    _database = await _initDB(databaseName);

    log('DataBaseHelper - database(): Done');

    return _database!;
  }

  Future<void> deleteDatabase() => databaseFactory.deleteDatabase(databaseName);

  //get database from path and open it
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    log('DataBaseHelper - _initDB(): Joined both db and file path');
    log('DataBaseHelper - _initDB(): Opening database');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //create database
  Future _createDB(Database db, int version) async {
    //creates a datatable, can make more
    log('DataBaseHelper - _createDB(): Creating DB with weeklyRoutinesTable');

    await db.execute('''
        CREATE TABLE $tableWeeklyRoutines (
        ${WeeklyRoutineFields.id} INTEGER PRIMARY KEY,
        ${WeeklyRoutineFields.week} INTEGER NOT NULL,
        ${WeeklyRoutineFields.dateCreated} TEXT NOT NULL,
        ${WeeklyRoutineFields.listOfWorkouts} TEXT NOT NULL
        )''');

    log('DataBaseHelper - _createDB(): Done');
  }

  Future<WeeklyRoutine> create(WeeklyRoutine weeklyRoutine) async {
    final db = await instance.database;

    log('DatabaseHelper - create(): Inserting weeklyRoutine into DB');

    final id = await db.insert(tableWeeklyRoutines, weeklyRoutine.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);

    log('DataBaseHelper - create(): Insertion complete -> copying id...');

    return weeklyRoutine.copy(id: id);
  }

  Future<WeeklyRoutine> readWeeklyRoutine(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableWeeklyRoutines,
      columns: WeeklyRoutineFields.values,
      where: '${WeeklyRoutineFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return WeeklyRoutine.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<WeeklyRoutine>> readAllWeeklyRoutines() async {
    final db = await instance.database;

    final orderBy = '${WeeklyRoutineFields.dateCreated} ASC';

    final result = await db.query(tableWeeklyRoutines, orderBy: orderBy);

    return result.map((json) => WeeklyRoutine.fromMap(json)).toList();
  }

  Future<int> update(WeeklyRoutine weeklyRoutine) async {
    final db = await instance.database;

    log('DataBaseHelper - update(): Updating WeeklyRoutine ${weeklyRoutine.getWeek()}');

    return db.update(
      tableWeeklyRoutines,
      weeklyRoutine.toMap(),
      where: '${WeeklyRoutineFields.id} = ?',
      whereArgs: [weeklyRoutine.id],
    );
  }

  //delete item in db
  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableWeeklyRoutines,
      where: '${WeeklyRoutineFields.id} = ?',
      whereArgs: [id],
    );
  }

  //close db
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

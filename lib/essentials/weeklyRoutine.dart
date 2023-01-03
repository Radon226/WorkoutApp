import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:radons_workout_app/essentials/workout.dart';

const String tableWeeklyRoutines = 'weeklyRoutines';

//for WorkoutDatabase
class WeeklyRoutineFields {
  static final List<String> values = [id, week, dateCreated, listOfWorkouts];

  static const String id = 'id';
  static const String week = 'week';
  static const String dateCreated = 'dateCreated';
  static const String listOfWorkouts = 'listOfWorkouts';
}

//should only be created once a week
class WeeklyRoutine {
  final int? id;
  final int week;
  final DateTime dateCreated;
  final List<Workout> listOfWorkouts;

  const WeeklyRoutine(
      {this.id,
      required this.week,
      required this.dateCreated,
      required this.listOfWorkouts});

  int? getId() => id;
  int getWeek() => week;
  DateTime getDate() => dateCreated;
  List<Workout> getlistOfWorkouts() => listOfWorkouts;

  WeeklyRoutine copy(
          {int? id,
          int? week,
          DateTime? dateCreated,
          List<Workout>? listOfWorkouts}) =>
      WeeklyRoutine(
        id: id ?? this.id,
        week: week ?? this.week,
        dateCreated: dateCreated ?? this.dateCreated,
        listOfWorkouts: listOfWorkouts ?? this.listOfWorkouts,
      );

  Map<String, Object?> toMap() {
    //log('weeklyRoutine - toJson(): Starting method...');

    List<Map> listOfWorkouts =
        this.listOfWorkouts.map((i) => i.toJson()).toList();

    //turns into json/String (REMEMBER JSON IS A STRING)
    String encodedList = jsonEncode(listOfWorkouts);

    //converts date object to a formatted string
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dateCreated);

    //returns a map
    final map = {
      WeeklyRoutineFields.id: id,
      WeeklyRoutineFields.week: week,
      WeeklyRoutineFields.dateCreated: formattedDate,
      WeeklyRoutineFields.listOfWorkouts: encodedList,
    };

    map.removeWhere((key, value) => value == null);

    //log('weeklyRoutine - toMap(): returning map');

    return map;
  }

  //returns from map/json to an object (WeeklyRoutine)
  factory WeeklyRoutine.fromMap(Map<String, Object?> json) {
    //converts json to map list

    //need to figure out how to convert json to string back to json
    var decodeList = jsonDecode(json[WeeklyRoutineFields.listOfWorkouts] as String);

    var workoutJsonToList = decodeList as List;

    List<Workout> _listOfWorkouts =
        workoutJsonToList.map((workout) => Workout.fromJson(workout)).toList();

    var formatter = DateFormat('yyyy-MM-dd'); // Save this to DB
    DateTime dateCreated =
        formatter.parse(json[WeeklyRoutineFields.dateCreated] as String);

    return WeeklyRoutine(
      id: json[WeeklyRoutineFields.id] as int?,
      week: json[WeeklyRoutineFields.week] as int,
      dateCreated: dateCreated,
      listOfWorkouts: _listOfWorkouts,
    );
  }
}
